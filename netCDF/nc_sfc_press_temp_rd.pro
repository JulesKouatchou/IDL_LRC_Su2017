FUNCTION NC_sfc_press_temp_rd

    ;+
    ; Name:
    ;      SFC_PRES_TEMP_RD
    ; Purpose:
    ;      This function is an IDL version of the netCDF tutorial program SFC_PRES_TEMP_RD.
    ;      It reads a netCDF input file (sfc_pres_temp.nc) and returns a data structure
    ;      containing two 12 x 6 x 2 arrays of single-precision floating-point numbers, 
    ;      'pressure' and 'temperature', along with coordinate variables 'longitude' and 
    ;      'latitude'.
    ;
    ;      In this example, each variable read from the file is stored in a data structure 
    ;      along with its attributes.  The data structures for all variable are returned in
    ;      a single hierarchical (nested) data structure.  Data does not have to be
    ;      stored in structures, but it allows related information to be organized,
    ;      accessed, and passed by referencing only a single structure variable.
    ;
    ;      Sample usage:
    ;
    ;      IDL> data = sfc_pres_temp_rd()        
    ;      IDL> help, data, /structure
    ;      ** Structure <225e570>, 4 tags, length=744, data length=744, refs=1:
    ;         LONGITUDE       STRUCT    -> <Anonymous> Array[1]
    ;         LATITUDE        STRUCT    -> <Anonymous> Array[1]
    ;         PRESSURE        STRUCT    -> <Anonymous> Array[1]
    ;         TEMPERATURE     STRUCT    -> <Anonymous> Array[1]
    ;      IDL> help, data.pressure, /structure
    ;      ** Structure <225d050>, 3 tags, length=312, data length=312, refs=2:
    ;         NAME            STRING    'pressure'
    ;         VALUES          FLOAT     Array[12, 6]
    ;         UNITS           STRING    'hPa'
    ;      IDL> print, data.latitude.values 
    ;            25.0000      30.0000      35.0000      40.0000      45.0000      50.0000
    ;
    ;      Error handling is not included in this example program.  NetCDF errors will cause 
    ;      IDL to halt execution and issue an error message.  These errors can
    ;      be caught and handled by the user, if desired.
    ; Calling sequence:
    ;      data = SFC_PRES_TEMP_RD()
    ; Input:
    ;      None.
    ; Output:
    ;      This function returns a data structure containing variables from the netCDF input file.
    ; Keywords:
    ;      None.
    ; Files:
    ;      Data are read from the netCDF file 'sfc_pres_temp.nc' created by SFC_PRES_TEMP_WR.
    ; Author and history:
    ;      Kenneth P. Bowman.  2007-02-10.  Visit http://idl.tamu.edu/ for more information.
    ;      Copyright 2007 Kenneth P. Bowman.
    ;      See the UNIDATA netCDF copyright file for conditions of use.
    ;-
    
    COMPILE_OPT IDL2                                    ;Set compile options
    
    file_name = 'sfc_pres_temp.nc'                      ;Name of file to create
    
    id = NCDF_OPEN(file_name)                           ;Open netCDF input file
    
    NCDF_VARGET, id, 'longitude', values                ;Read longitude from file
    NCDF_ATTGET, id, 'longitude', 'units', units        ;Read longitude units attribute
    longitude   = {name   : 'longitude', $              ;Create longitude data structure
                   values : values, $
                   units  : STRING(units)}
    
    NCDF_VARGET, id, 'latitude', values                 ;Read latitude from file
    NCDF_ATTGET, id, 'latitude', 'units', units         ;Read latitude units attribute
    latitude    = {name   : 'latitude', $               ;Create latitude data structure
                   values : values, $
                   units  : STRING(units)}
    
    NCDF_VARGET, id, 'pressure', values                 ;Read pressure from file
    NCDF_ATTGET, id, 'pressure', 'units', units         ;Read pressure units attribute
    pressure    = {name   : 'pressure', $               ;Create pressure data structure
                   values : values, $
                   units  : STRING(units)}
    
    NCDF_VARGET, id, 'temperature', values              ;Read temperature from file
    NCDF_ATTGET, id, 'temperature', 'units', units      ;Read temperature units attribute
    temperature = {name   : 'temperature', $            ;Create temperature data structure
                   values : values, $
                   units  : STRING(units)}
    
    NCDF_CLOSE, id                                      ;Close netCDF input file
    
    RETURN, {longitude   : longitude, $                 ;Return data structure with all variables
             latitude    : latitude,  $
             pressure    : pressure,  $
             temperature : temperature}
    
END

