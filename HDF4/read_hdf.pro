PRO read_hdf
    FILE_NAME = "MYD04_L2.A2013060.1300.051.2013062021359.hdf"   ; nrows=203, ncols=135
    SDS_NAME = "Optical_Depth_Land_And_Ocean"
 
    ; Open the file
    sd_id = HDF_SD_START(FILE_NAME, /read)
 
    ; Find the index of the sds to read using its name
    sds_index = HDF_SD_NAMETOINDEX(sd_id, SDS_NAME)
 
    ; Select it
    sds_id = HDF_SD_SELECT(sd_id, sds_index)
 
    ; Get data set information including dimension information
    HDF_SD_GetInfo, sds_id, name = SDS_NAME, natts = num_attributes, ndim = num_dims, dims = dim_sizes
    nrows = dim_sizes[1]
    ncols = dim_sizes[0]
 
    ; Define subset to read. start is [0,0].
    start = INTARR(2) ; the start position of the data to be read
    start[0] = 0
    start[1] = 0
    edges = INTARR(2) ; the number of elements to read in each dimension
    edges[0] = dim_sizes[0]
    edges[1] = dim_sizes[1]
 
    ; Read the data : you can notice that here, it is not needed to allocate the data array yourself
    HDF_SD_GETDATA, sds_id, data, start = start, count = edges
 
    i=200 ; row index
    j=125 ; col index
    PRINT, FORMAT = '(I," ",$)', data[j,i]    ; 65
    PRINT, ""
 
    ; end access to SDS
    HDF_SD_ENDACCESS, sds_id
 
    ; close the hdf file
    HDF_SD_END, sd_id
 
END
