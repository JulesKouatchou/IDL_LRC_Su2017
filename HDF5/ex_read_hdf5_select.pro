PRO ex_read_hdf5_select  
  
   ; Open the HDF5 file.  
   file_id = H5F_OPEN('hdf5_test.h5')  
  
   ; Open the image dataset within the file.  
   dataset_id1 = H5D_OPEN(file_id, '/images/Eskimo')  
     
   ; Open up the dataspace associated with the Eskimo image.  
   dataspace_id = H5D_GET_SPACE(dataset_id1)  
     
   ; Now choose our hyperslab. We will pick out only the central  
   ; portion of the image.  
   start = [100, 100]  
   count = [200, 200]  
   ; Be sure to use /RESET to turn off all other  
   ; selected elements.  
   H5S_SELECT_HYPERSLAB, dataspace_id, start, count,  
      STRIDE=[2, 2], /RESET  
  
   ; Create a simple dataspace to hold the result. If we  
   ; didn't supply  
   ; the memory dataspace, then the result would be the same size  
   ; as the image dataspace, with zeroes everywhere except our  
   ; hyperslab selection.  
   memory_space_id = H5S_CREATE_SIMPLE(count)  
     
   ; Read in the actual image data.  
   image = H5D_READ(dataset_id1, FILE_SPACE=dataspace_id, $  
      MEMORY_SPACE=memory_space_id)  
  
   ; Now open and read the color palette associated with  
   ; this image.  
   dataset_id2 = H5D_OPEN(file_id, '/images/Eskimo_palette')  
   palette = H5D_READ(dataset_id2)  
  
   ; Close all our identifiers so we don't leak resources.  
   H5S_CLOSE, memory_space_id  
   H5S_CLOSE, dataspace_id  
   H5D_CLOSE, dataset_id1  
   H5D_CLOSE, dataset_id2  
   H5F_CLOSE, file_id  
  
   ; Display the data.  
   DEVICE, DECOMPOSED=0  
   WINDOW, XSIZE=count[0], YSIZE=count[1]  
   TVLCT, palette[0,*], palette[1,*], palette[2,*]  
     
   ; We need to use /ORDER since the image is stored   
   ; top-to-bottom.  
TV, image, /ORDER  
  
END  
