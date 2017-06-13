

FUNCTION HDF5_getListVariableAttribute, h5fid, VARNAME
    ;--------------------------------------------------------
    ; Description: Provides the list of attributes associated
    ;              with a variable.
    ;
    ; Input parameters:
    ;   - h5fid:    file identifier
    ;   - VARNAME:  variable name
    ;   
    ; Returned value:
    ;   - List of attributes associated with the variable
    ;--------------------------------------------------------

    ;- Check arguments
    if (n_params() ne 2) then $
    message, 'Usage" RESULT = HDF5_getListVariableAttribute(h5fid, VARNAME)'

    if (n_elements(h5fid) eq 0) then $
    message, 'Argument h5fid is undefined'

    if (n_elements(varname) eq 0) then $
    message, 'Argument VARNAME is undefined'

    ;- Set default return value
    attnames = ''

    ;- Get attribute information
    if (varname eq '' ) then begin
       ; Global attributes
       natts = H5A_GET_NUM_ATTRS(h5fid)
    endif else begin
       varid = H5D_OPEN(h5fid, varname)
       natts = H5A_GET_NUM_ATTRS(varid)
    endelse

    ;- If attributes were found, get attribute names
    if (natts gt 0) then begin
       attnames = strarr(natts)
       for index = 0L, natts - 1L do begin
           if (varname eq '') then begin
              name = ncdf_attname(cdfid, index, /global )
           endif else begin
              attribute_id = H5A_OPEN_IDX(varid,index)
              name = H5A_GET_NAME(attribute_id)
              H5A_CLOSE, attribute_id
           endelse
           attnames[index] = name
       endfor
    endif

    ;- Return the result
    return, attnames

END
