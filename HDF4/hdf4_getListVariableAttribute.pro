FUNCTION HDF4_getListVariableAttribute, hdfid, varname


    ;check arguments
    if (n_params() ne 2) then $
       message, 'Usage" RESULT = HDF_SD_ATTDIR(HDFID, VARNAME)'
    if (n_elements(hdfid) eq 0) then $
       message, 'HDFID is undefined'
    if (n_elements(varname) eq 0) then $
       message, 'VARNAME is undefined'

    ;- Set default return value
    attnames = ' '

    ;- Get attribute information
    if (varname eq '') then begin
       HDF_SD_FILEINFO , hdfid , nvars, natts
    endif else begin
       index = HDF_SD_NAMETOINDEX(hdfid, varname)
       varid = HDF_SD_SELECT(hdfid, index)
       HDF_SD_GETINFO, varid , natts=natts
    endelse

    ;- If attributes were found, get attribute names
    if (natts gt 0) then begin
       attnames = strarr(natts)
       for index = 0L, natts - 1L do begin
           if (varname eq '') then begin
              HDF_SD_ATTRINFO, hdfid , index, name=name
           endif else begin
              HDF_SD_ATTRINFO, varid , index, name=name
           endelse
           attnames[index] = name
       endfor
    endif
    
    ;- End access to this variable if necessary
    if (varname ne '') then HDF_SD_ENDACCESS, varid

    ;- Return the result
    return, attnames

END
