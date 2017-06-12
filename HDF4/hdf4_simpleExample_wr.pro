
pro HDF4_simpleExample_wr

    file_name = 'simple_xy.hdf'                           ;Name of file to create

    ny   = 12                                             ;Size of x-dimension
    nx   =  6                                             ;Size of y-dimension
    data = LINDGEN(ny, nx)                                ;Create 2-D array of dummy data


    ;--------------------
    ; Create the HDF file
    ;--------------------
    hdfid = HDF_SD_START(file_name, /CREATE)

    vid  = HDF_SD_CREATE(hdfid, 'data', [ny, nx], /LONG)

    ; Define the dimensions
    yid  = HDF_SD_DIMGETID(vid, 0)
    HDF_SD_DIMSET, yid, NAME='y'

    xid  = HDF_SD_DIMGETID(vid, 1)
    HDF_SD_DIMSET, xid, NAME='x'

    ;---------------------------
    ; Write the data in the file
    ;---------------------------
    HDF_SD_ADDDATA, vid, data

    HDF_SD_ENDACCESS, vid

    ; Close the file
    HDF_SD_END, hdfid

END
