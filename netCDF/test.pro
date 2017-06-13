pro test

    fname = 'ncFiles/MERRA300.prod.assim.20050101.1x1.25.nc'

    IF (file_test(fname) EQ 1) then begin
       print, fname
       cdfid = ncdf_open(fname)

       varNames = NC_getListVariables(cdfid)

       print, varNames

       varAttr = NC_getListVariableAttribute (cdfid, 'T')

       print, varAttr

       res = ncdf_inquire(cdfid)


       NC_printVariablesInfo, cdfid


       ncdf_close, cdfid
    ENDIF
end
