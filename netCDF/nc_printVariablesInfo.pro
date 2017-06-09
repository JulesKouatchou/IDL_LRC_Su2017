;-------------------------------------------------
; Print the variables information of a netCDF file
;-------------------------------------------------

PRO NC_printVariablesInfo, cdfid

    res = NCDF_INQUIRE(cdfid)

    ;.... get and print dimension info about file
    print,''
    print,'Dimension names and sizes:'
    print,'--------------------------------'
    print,'   No.  Size                Name'
    print,'--------------------------------'

    ; Get the number of dimensions
    num_dims = res.ndims

    dim_size = lonarr(num_dims)
    dim_name = strarr(num_dims)

    ; Loop over the number of dimensions
    for n=0,num_dims-1 do begin
        ; For each dimension, get its name and size
        NCDF_DIMINQ,cdfid,n,name,size
        dim_name(n) = name
        dim_size(n) = size
        print,n,dim_size(n),dim_name(n),form='(2i6,a20)'
    end
    print,'--------------------------------'

    ;.... get and print variable info about file
    print,''
    print,'Variable names and sizes:'
    print,'--------------------------------------------------------------------'
    print,'   No.  Atts  Dims                  Name    Dimensions'
    print,'--------------------------------------------------------------------'
    var_name = strarr(res.nvars)
    var_dims = lonarr(res.nvars)
    var_atts = lonarr(res.nvars)
    for n=0,res.nvars-1 do begin
        vres = NCDF_VARINQ(cdfid,n)
        var_name(n) = vres.name
        var_dims(n) = vres.ndims
        var_atts(n) = vres.natts
        print,n,var_atts(n),var_dims(n),'  ',vres.name,'  ',dim_size(vres.dim) $
          ,form='(3i6,a2,a20,a2,12i6)'
    end
    print,'--------------------------------------------------------------------'

END
