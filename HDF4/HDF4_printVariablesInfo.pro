;-------------------------------------------------
; Print the variables information of a HDF4 file
;-------------------------------------------------

PRO HDF4_printVariablesInfo, hdfid

    ;- Get file information
    HDF_SD_FILEINFO, hdfid, nvars, ngatts

;    ;.... get and print dimension info about file
;    print,''
;    print,'Dimension names and sizes:'
;    print,'--------------------------------'
;    print,'   No.  Size                Name'
;    print,'--------------------------------'
;
;    ; Get the number of dimensions
;    num_dims = res.ndims
;
;    dim_size = lonarr(num_dims)
;    dim_name = strarr(num_dims)
;
;    ; Loop over the number of dimensions
;    for n=0,num_dims-1 do begin
;        ; For each dimension, get its name and size
;        dim_id = HDF_SD_DIMGETID (hdfid, n)
;        HDF_SD_DIMGET, dim_id, NAME=name, COUNT=size
;        dim_name(n) = name
;        dim_size(n) = size
;        print,n,dim_size(n),dim_name(n),form='(2i6,a20)'
;    end
;    print,'--------------------------------'

    ;.... get and print variable info about file
    print,''
    print,'Variable names and sizes:'
    print,'--------------------------------------------------------------------'
    print,'   No.  Atts  Dims                  Name    Dimensions'
    print,'--------------------------------------------------------------------'
    var_name = strarr(nvars)
    var_dims = lonarr(nvars)
    var_atts = lonarr(nvars)
    for n=0,nvars-1 do begin
        varid = HDF_SD_SELECT(hdfid, n)
        HDF_SD_GETINFO, varid, name=my_name,  natts=my_natts, $
                               ndim=my_ndims, dims=dimVec
        var_name(n) = my_name
        var_dims(n) = my_ndims
        var_atts(n) = my_natts
        HDF_SD_ENDACCESS, varid
        print,n,var_atts(n),var_dims(n),'  ',var_name(n),'  ',dimVec $
          ,form='(3i6,a2,a20,a2,12i6)'
    end
    print,'--------------------------------------------------------------------'

END
