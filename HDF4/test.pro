pro test

    varName = 'T'
    fname = 'hdFiles/MERRA300.prod.assim.tavg3_3d_chm_Fv.20050101.hdf'

    IF (file_test(fname) EQ 0) THEN BEGIN
       print, 'File Name: ', fname
       MESSAGE, 'The file does not exist'
    ENDIF
       
    print, fname

    ; Open the file to read
    ;----------------------
    hdfid = HDF_SD_START(fname, /read)

    ; Get the list of all the variables in the file
    varNames = HDF4_getListVariables(hdfid)

    n = n_elements(varNames)

    print, ''
    print, 'List of all the variables (',n,') in the file:', form='(a,i2,a)'
    print, '   ', varNames

    ; Get the list of all the attributes of a variable
    varAttr = HDF4_getListVariableAttribute (hdfid, varName)

    print, ''
    print, 'List of attributes of the variable: ', varName
    print, varAttr

    ; List all the variables and their information
    HDF4_printVariablesInfo, hdfid

    ; Read the temperature data
    HDF4_VARREAD_WRAPPER, hdfid, varName, data

    print, 'T(1,1): ', data(1,1)

    ; Close the file
    ;---------------
    HDF_SD_END, hdfid
end
