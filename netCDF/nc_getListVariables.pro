FUNCTION NC_getListVariables, CDFID
    ;--------------------------------------------------------------
    ; Description: Get the list of variables.
    ;
    ; Input:
    ;   - CDFID:   file identifier
    ;
    ; Returned value:
    ;   - List of variables in the file
    ;--------------------------------------------------------------

     ;- Check arguments
     if (n_params() ne 1) then $
        message, 'Usage. RESULT = getListVariables(CDFID)'

     if (n_elements(cdfid) eq 0) then $
        message, 'Argument CDFID is undefined'

     ;- Set default return value
     varnames = ''

     ;- Get file information
     fileinfo = NCDF_INQUIRE(cdfid)
     nvars = fileinfo.nvars

     ;- If variables were found, get variable names
     if (nvars gt 0) then begin
        varnames = strarr(nvars)
        for index = 0L, nvars -1L do begin
            varinfo = NCDF_VARINQ(cdfid, index)
            varnames[index] = varinfo.name
        endfor
     endif

     ;- Return the result
     return, varnames
END
