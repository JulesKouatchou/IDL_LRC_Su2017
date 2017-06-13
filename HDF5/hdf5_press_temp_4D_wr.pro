PRO HDF5_press_temp_4D_wr
    ;--------------------------------------------------------
    ; Description: Create a HDF5 output file (pres_temp_4d.h5)
    ;              and writes two 12 x 6 x 2 arrays
    ;              'pressure' and 'temperature', to the file, 
    ;              along with coordinate variables 'longitude' 
    ;              and 'latitude'.
    ;--------------------------------------------------------

    COMPILE_OPT IDL2                                 ;Set compile options

    file_name  = 'pres_temp_4d.h5'                   ;Name of file to create

    ;      Compute coordinate variables

    nx      =     12                                 ;Number of x-coordinates
    xmin    = -125.0                                 ;Minimum longitude
    xmax    =  -70.0                                 ;Maximum longitude
    dx      = (xmax - xmin)/(nx - 1)                 ;Longitude spacing
    x       = xmin + dx*FINDGEN(nx)                  ;Compute x-coordinates

    ny      =      6                                 ;Number of y-coordinates
    ymin    =   25.0                                 ;Minimum latitude
    ymax    =   50.0                                 ;Maximum latitude
    dy      = (ymax - ymin)/(ny - 1)                 ;Latitude spacing
    y       = ymin + dy*FINDGEN(ny)                  ;Compute y-coordinates
    
    nz      =      2                                 ;Number of vertical levels
    nt      =      3                                 ;Number of time steps

    z       = FINDGEN(nz)
    timeArr = FINDGEN(nt)*3*60

    ;      Compute dependent variables

    pressure    = 900.0 + FINDGEN(nx, ny, nz)        ;Create 2-D array of pressure data
    temperature =   9.0 + FINDGEN(nx, ny, nz)        ;Create 2-D array of temperature data

    IF (FILE_TEST(file_name)) THEN FILE_DELETE, file_name

    ;      Create output file and write data

    h5fid  = H5F_CREATE(file_name)  

    ; Get data type and space needed to create the dataset
    datatype_pid  = H5T_IDL_CREATE(pressure)
    datatype_tid  = H5T_IDL_CREATE(temperature)

    sliceDims = [nx, ny, nz, 1]
    fullDims  = [nx, ny, nz, nt]

    dataspace_pid = H5S_CREATE_SIMPLE(sliceDims, MAX_DIMENSIONS=fullDims)
    dataspace_tid = H5S_CREATE_SIMPLE(sliceDims, MAX_DIMENSIONS=fullDims)

    ; create dataset in the output file  
    dataset_pid   = H5D_CREATE(h5fid, 'pressure',    datatype_pid, dataspace_pid, CHUNK_DIMENSIONS=sliceDims)
    dataset_tid   = H5D_CREATE(h5fid, 'temperature', datatype_tid, dataspace_tid, CHUNK_DIMENSIONS=sliceDims)

    ;; Reserve the memory associate with the dataset  
    meorysapce_pid = H5D_GET_SPACE(dataset_pid)
    meorysapce_tid = H5D_GET_SPACE(dataset_tid)

    ;; write data to dataset  
    FOR s = 0, nt-1 DO BEGIN                                             ;Time index
       H5D_EXTEND, dataset_pid, [sliceDims[0L:2L],s+1L]
       filespace_pid = H5D_GET_SPACE(dataset_pid)
       H5S_SELECT_HYPERSLAB, filespace_pid, [0, 0, 0, s], sliceDims, /RESET
       H5D_WRITE, dataset_pid, pressure, FILE_SPACE=filespace_pid, MEMORY_SPACE=meorysapce_pid
       H5S_CLOSE, filespace_pid
    
       H5D_EXTEND, dataset_tid, [sliceDims[0L:2L],s+1L]
       filespace_tid = H5D_GET_SPACE(dataset_tid)
       H5S_SELECT_HYPERSLAB, filespace_tid, [0, 0, 0, s], sliceDims, /RESET
       H5D_WRITE, dataset_tid, temperature, FILE_SPACE=filespace_tid, MEMORY_SPACE=meorysapce_tid
       H5S_CLOSE, filespace_tid
    ENDFOR

    addVariableAttribute, dataset_pid, attribute_name='units',       attribute_value='hPa'
    addVariableAttribute, dataset_pid, attribute_name='ScaleFactor', attribute_value=1.0
    addVariableAttribute, dataset_pid, attribute_name='Offset',      attribute_value=0.0

    addVariableAttribute, dataset_tid, attribute_name='units',       attribute_value='hPa'
    addVariableAttribute, dataset_tid, attribute_name='ScaleFactor', attribute_value=1.0
    addVariableAttribute, dataset_tid, attribute_name='Offset',      attribute_value=0.0

    coorList = ['longitude', 'latitude', 'level', 'time']
    addVariableAttribute, dataset_pid, attribute_name='coordinates', attribute_value=coorList
    addVariableAttribute, dataset_tid, attribute_name='coordinates', attribute_value=coorList

    ; Create the dimension variables
    ;-------------------------------
    datatype_lonid  = H5T_IDL_CREATE(x)
    datatype_latid  = H5T_IDL_CREATE(y)
    datatype_levid  = H5T_IDL_CREATE(z)
    datatype_timid  = H5T_IDL_CREATE(timeArr)

    dataspace_lonid = H5S_CREATE_SIMPLE(nx)
    dataspace_latid = H5S_CREATE_SIMPLE(ny)
    dataspace_levid = H5S_CREATE_SIMPLE(nz)
    dataspace_timid = H5S_CREATE_SIMPLE(nt)

    dataset_lonid   = H5D_CREATE(h5fid, 'longitude', datatype_lonid, dataspace_lonid)
    dataset_latid   = H5D_CREATE(h5fid, 'latitude',  datatype_latid, dataspace_latid)
    dataset_levid   = H5D_CREATE(h5fid, 'level',     datatype_levid, dataspace_levid)
    dataset_timid   = H5D_CREATE(h5fid, 'time',      datatype_timid, dataspace_timid)

    addVariableAttribute, dataset_lonid, attribute_name='units', attribute_value='degrees east'
    addVariableAttribute, dataset_latid, attribute_name='units', attribute_value='degrees north'

    H5D_WRITE, dataset_lonid, x
    H5D_WRITE, dataset_latid, y
    H5D_WRITE, dataset_levid, z
    H5D_WRITE, dataset_timid, timeArr

    ; close all open identifiers  
    ;---------------------------

    H5D_CLOSE, dataset_lonid
    H5S_CLOSE, dataspace_lonid
    H5T_CLOSE, datatype_lonid
    
    H5D_CLOSE, dataset_latid
    H5S_CLOSE, dataspace_latid
    H5T_CLOSE, datatype_latid

    H5D_CLOSE, dataset_levid
    H5S_CLOSE, dataspace_levid
    H5T_CLOSE, datatype_levid

    H5D_CLOSE, dataset_timid
    H5S_CLOSE, dataspace_timid
    H5T_CLOSE, datatype_timid

    H5S_CLOSE, meorysapce_pid
    H5D_CLOSE, dataset_pid
    H5S_CLOSE, dataspace_pid
    H5T_CLOSE, datatype_pid

    H5S_CLOSE, meorysapce_tid
    H5D_CLOSE, dataset_tid
    H5S_CLOSE, dataspace_tid
    H5T_CLOSE, datatype_tid

    H5F_CLOSE,h5fid
END

