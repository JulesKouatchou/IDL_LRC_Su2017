
FUNCTION HDF5_simpleExample_rd

    file_name = 'simple_xy.h5'                           ;Name of file to create

    ;--------------------
    ; OPEN the HDF file
    ;--------------------
    h5fid = H5F_OPEN(file_name)

    ; Open the data set
    vid  = H5D_OPEN(h5fid, 'data')

    ;Read the data
    data = H5D_READ(vid)

    ; Close the data set
    H5D_CLOSE, vid

    ; Close the file
    H5F_CLOSE, h5fid

    dims = size(data, /dimensions)
    print, 'Dimensions of data: ', dims

    i = WHERE((data - LINDGEN(N_ELEMENTS(data))) NE 0, count)   ;Check variable contents
    IF (count NE 0) THEN MESSAGE, 'Error reading data.'

    RETURN, data


END
