FUNCTION HDF4_getListVariables, hdfid

    if (n_params() ne 1) then $
    message, 'Usage. RESULT = HDF4_getListVariables(HDFID)'

    if (n_elements(hdfid) eq 0) then $
    message, 'HDFID is undefined'

    ;- Set default return value
    varnames = ''
    ;- Get file information
    HDF_SD_FILEINFO, hdfid, nvars, ngatts

    ;- If variables were found, get variable names
    if (nvars gt 0) then begin
       varnames = strarr(nvars)
       for index = 0L, nvars - 1L do begin
           varid = HDF_SD_SELECT(hdfid, index)
           HDF_SD_GETINFO, varid, name=name
           HDF_SD_ENDACCESS, varid
           varnames[index] = name
       endfor
    endif

    ;- Return the result
    return, varnames

END
