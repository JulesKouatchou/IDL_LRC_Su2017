PRO read_col_file, fname

    header = StrArr(3)
    snam = ''
    sloc = ''
    ;----------------------
    ; Initialize the arrays
    ;----------------------
    longitudes        = [-999]
    latitudes         = [-999]
    station_names     = ['']
    station_locations = ['']

    ;---------------------------
    ; Set the format for reading
    ;---------------------------
    fmt = '(A16,x,f8.2,x,f8.2,3x,A50)'

    ;--------------
    ; Open the file
    ;--------------
    OPENR, lun, fname, /Get_Lun

    ; Read the header
    READF, lun, header

    ; Read each line and add entries to the array
    WHILE (~ EOF(lun)) DO BEGIN
         readf, lun, snam, lat, lon, sloc, format=fmt
         latitudes         = [latitudes, lat]
         longitudes        = [longitudes, lon]
         station_names     = [station_names, STRTRIM(snam)]
         station_locations = [station_locations, STRTRIM(sloc)]
         ;print, snam, lat, lon, sloc, format=fmt
    ENDWHILE

    ;--------------
    ; Close the file
    ;--------------
    CLOSE, lun
    print, N_ELEMENTS(latitudes), N_ELEMENTS(longitudes), N_ELEMENTS(station_names), N_ELEMENTS(station_locations)
    latitudes = latitudes[1:*]
    longitudes = longitudes[1:*]
    station_names = station_names[1:*]
    station_locations = station_locations[1:*]
    print, N_ELEMENTS(latitudes), N_ELEMENTS(longitudes), N_ELEMENTS(station_names), N_ELEMENTS(station_locations)
    
END
