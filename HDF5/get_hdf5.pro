function get_hdf5,f,branch,var_name
   
   fid = h5f_open(f)             ; open file

   gid = h5g_open(fid,branch)    ; access the branch
   did = h5d_open(gid,var_name)  ; access the variable
   var = h5d_read(did)           ; read the variable
   
   h5d_close,did                 ; close the variable
   h5f_close,fid                 ; close file
   
   return,var                    ; send back the data
   
end
