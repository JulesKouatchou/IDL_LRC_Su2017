PRO HDF4_VARREAD_WRAPPER, hdfid, varname, data, _extra=EXTRA_KEYWORDS

    ;- Check arguments
    if (n_params() ne 3) then $
       message, 'Usage- HDF_SD_VARREAD, HDFID, VARNAME, DATA'
    if (n_elements(hdfid) eq 0) then $
       message, 'Argument HDFID is undefined'
    if (n_elements(varname) eq 0) then $
       message, 'Argument VARNAME is undefined'

    if (arg_present(data) eq 0) then $
       message, 'Argument DATA cannot be modified'

    ;- Get index of the requested variable
    index = HDF_SD_NAMETOINDEX(hdfid, varname)
    if (index lt 0) then $
    message, 'SDS was not found- ' + varname

    ;- Select and read the SDS
    varid = HDF_SD_SELECT(hdfid, index)
    HDF_SD_GETDATA, varid, data, _extra=extra_keywords
    HDF_SD_ENDACCESS, varid

END
