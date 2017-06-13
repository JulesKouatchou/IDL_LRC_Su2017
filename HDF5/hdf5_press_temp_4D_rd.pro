FUNCTION HDF5_press_temp_4D_rd, s
    ;--------------------------------------------------------
    ; Description: Read a HDF5 input file (pres_temp_4d.h5) 
    ;              and returns  a data structure containing
    ;              two arrays 'pressure' and 'temperature', 
    ;              to the file, along with coordinate 
    ;              variables 'longitude' and 'latitude'.
    ;
    ; Input parameters:
    ;   - s:      record number in the file
    ;--------------------------------------------------------


    COMPILE_OPT IDL2                                 ;Set compile options

    file_name  = 'pres_temp_4d.h5'                   ;Name of file to create

    IF NOT FILE_TEST(file_name) THEN $
       MESSAGE, 'File does not exist'

    IF (N_PARAMS() EQ 0) THEN s = 0                  ;Default time index

    s0 = LONG(s)                                     ;Ensure time index is LONG

    ;      Open input file
    h5fid  = H5F_OPEN(file_name)  

    lon_vid = H5D_OPEN(h5fid, 'longitude')
    longitude = H5D_READ(lon_vid)
    H5D_CLOSE, lon_vid
    nx = N_ELEMENTS(longitude)

    lat_vid = H5D_OPEN(h5fid, 'latitude')
    latitude = H5D_READ(lat_vid)
    H5D_CLOSE, lat_vid
    ny = N_ELEMENTS(latitude)

    lev_vid = H5D_OPEN(h5fid, 'level')
    level = H5D_READ(lev_vid)
    H5D_CLOSE, lev_vid
    nz = N_ELEMENTS(level)

    print, nx, ny, nz

    ;sliceDims = [nx, ny, nz, 1]
    ;fullDims  = [nx, ny, nz, nt]

    ; Open the datasets within the file
    dataset_pid   = H5D_OPEN(h5fid, 'pressure'   )
    dataset_tid   = H5D_OPEN(h5fid, 'temperature')

    ; Open up the dataspace associated with pressure and temperature
    dataspace_pid = H5D_GET_SPACE(dataset_pid)
    dataspace_tid = H5D_GET_SPACE(dataset_tid)

    ; Choose the hyperslab

    START  = [ 0,  0,  0, s0]
    COUNT  = [nx, ny, nz, 1]
    STRIDE = [ 1,  1,  1, 1]
    BLOCK  = [ 1,  1,  1, 1]  

    H5S_SELECT_HYPERSLAB, dataspace_pid, START, COUNT, $
                                        BLOCK  = BLOCK, $
                                        STRIDE = STRIDE, /RESET

    H5S_SELECT_HYPERSLAB, dataspace_tid, START, COUNT, $
                                        BLOCK  = BLOCK, $
                                        STRIDE = STRIDE, /RESET

    ; Create a simple dataspace to hold the result. 
    ; If we ; didn't supply the memory dataspace, then the result 
    ; would be the same size as the data dataspace, with zeroes everywhere except our
    ; hyperslab selection.
    meorysapce_pid = H5S_CREATE_SIMPLE(COUNT)
    meorysapce_tid = H5S_CREATE_SIMPLE(COUNT)

    ; Read in the actual image data.
    values = H5D_READ(dataset_pid, FILE_SPACE=dataspace_pid, MEMORY_SPACE=meorysapce_pid)
    units = readVariableAttribute(dataset_pid, 'units')
    pressure    = {name   : 'pressure',     $           ;Create pressure data structure
                   values : REFORM(values), $
                   units  : STRING(units)}
    
    values = H5D_READ(dataset_tid, FILE_SPACE=dataspace_tid, MEMORY_SPACE=meorysapce_tid)
    units = readVariableAttribute(dataset_tid, 'units')
    temperature = {name   : 'temperature',  $           ;Create temperature data structure
                   values : REFORM(values), $
                   units  : STRING(units)}

    ; close all open identifiers  
    H5S_CLOSE, meorysapce_pid
    H5S_CLOSE, meorysapce_tid
    H5D_CLOSE, dataset_pid
    H5D_CLOSE, dataset_tid
    H5S_CLOSE, dataspace_pid
    H5S_CLOSE, dataspace_tid
    H5F_CLOSE, h5fid

    RETURN, {longitude   : longitude,   $               ;Return data structure with all variables
             latitude    : latitude,    $
             pressure    : pressure,    $
             temperature : temperature, $
             s           : s0           }

END

