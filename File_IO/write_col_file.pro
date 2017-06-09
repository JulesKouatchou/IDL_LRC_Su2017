PRO write_col_file

    header = StrArr(3)
    snam = ''
    sloc = ''

    rfilename =     'colDiagStationList.asc'
    wfilename = 'mod_colDiagStationList.asc'

    ;---------------------------
    ; Set the format for reading/writing
    ;---------------------------
    fmt = '(A16,x,f8.2,x,f8.2,3x,A50)'

    ;--------------
    ; Open the file
    ;--------------
    OPENR, lun1, rfilename, /Get_Lun
    OPENW, lun2, wfilename, /Get_Lun

    ; Read the header
    READF, lun1, header

    PRINTF, lun2, header

    ; Read each line and add entries to the array
    WHILE (~ EOF(lun1)) DO BEGIN
         READF, lun1, snam, lat, lon, sloc, format=fmt
         IF ( ABS(lat) GE 40.0) THEN BEGIN
            PRINTF, lun2, snam, lat, lon, sloc, format=fmt
         ENDIF
    ENDWHILE

    ;--------------
    ; Close the file
    ;--------------
    Free_Lun, lun1
    Free_Lun, lun2
    
END
