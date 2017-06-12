
FUNCTION HDF4_simpleExample_rd

    file_name = 'simple_xy.hdf'                           ;Name of file to create

    ;--------------------
    ; OPEN the HDF file
    ;--------------------
    hdfid = HDF_SD_START(file_name, /rEAD)

    index = HDF_SD_NAMETOINDEX(hdfid, 'data')
    vid  = HDF_SD_SELECT(hdfid, index)

    HDF_SD_GETDATA, vid, data

    HDF_SD_ENDACCESS, vid

    ; Close the file
    HDF_SD_END, hdfid

    dims = size(data, /dimensions)
    print, 'Dimensions of data: ', dims

    i = WHERE((data - LINDGEN(N_ELEMENTS(data))) NE 0, count)   ;Check variable contents
    IF (count NE 0) THEN MESSAGE, 'Error reading data.'

    RETURN, data


END
