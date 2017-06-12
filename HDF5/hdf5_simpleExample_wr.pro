
pro HDF5_simpleExample_wr

    file_name = 'simple_xy.h5'        ;Name of file to create

    ny   = 12                         ;Size of x-dimension
    nx   =  6                         ;Size of y-dimension
    data = LINDGEN(ny, nx)            ;Create 2-D array of dummy data

    IF (FILE_TEST(file_name)) THEN FILE_DELETE, file_name
    ;--------------------
    ; Create the HDF file
    ;--------------------
    h5fid = H5F_CREATE(file_name)

    ; Get data type and space needed to create the dataset
    datatype_id  = H5T_IDL_CREATE(data)  
    dataspace_id = H5S_CREATE_SIMPLE(size(data,/DIMENSIONS))

   ;; create dataset in the output file  
   dataset_id = H5D_CREATE(h5fid, 'data',datatype_id,dataspace_id)  

   ;; write data to dataset  
   H5D_WRITE,dataset_id,data  
  
   ;; close all open identifiers  
   H5D_CLOSE,dataset_id    
   H5S_CLOSE,dataspace_id  
   H5T_CLOSE,datatype_id  
   H5F_CLOSE,h5fid  

    ;vid  = HDF_SD_CREATE(hdfid, 'data', [ny, nx], /LONG)

    ; Define the dimensions
    ;yid  = HDF_SD_DIMGETID(vid, 0)
    ;HDF_SD_DIMSET, yid, NAME='y'

    ;xid  = HDF_SD_DIMGETID(vid, 1)
    ;HDF_SD_DIMSET, xid, NAME='x'


END
