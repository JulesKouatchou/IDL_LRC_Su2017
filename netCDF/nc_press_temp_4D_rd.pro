FUNCTION NC_press_temp_4D_rd, s

;+
; Name:
;      PRES_TEMP_4D_RD
; Purpose:
;      This function is an IDL version of the netCDF tutorial program PRES_TEMP_4D_RD.
;      It reads one time step from a netCDF input file (pres_temp_4d.nc) and returns 
;      a data structure containing two 12 x 6 x 2 arrays of single-precision floating-point 
;      numbers, 'pressure' and 'temperature', along with coordinate variables 'longitude' 
;      and 'latitude'.
;
;      In this example, each variable read from the file is stored in a data structure 
;      along with its attributes.  The data structures for all variable are returned in
;      a single hierarchical (nested) data structure.  Data does not have to be
;      stored in structures, but it allows related information to be organized,
;      accessed, and passed by referencing only a single structure variable.
;
;      Sample usage:
;
;      IDL> data = pres_temp_4d_rd(1)   
;      IDL> help, data, /structure      
;      ** Structure <225fa10>, 5 tags, length=1324, data length=1324, refs=1:
;         LONGITUDE       STRUCT    -> <Anonymous> Array[1]
;         LATITUDE        STRUCT    -> <Anonymous> Array[1]
;         PRESSURE        STRUCT    -> <Anonymous> Array[1]
;         TEMPERATURE     STRUCT    -> <Anonymous> Array[1]
;         S               LONG                 1
;      IDL> help, data.pressure, /structure
;      ** Structure <225f920>, 3 tags, length=600, data length=600, refs=2:
;         NAME            STRING    'pressure'
;         VALUES          FLOAT     Array[12, 6, 2]
;         UNITS           STRING    'hPa'
;
;      Comprehensive error handling is not included in this example program, 
;      although the program does check whether the time index is within range.
;      NetCDF errors will cause IDL to halt execution and issue an error message.  
;      These errors can be caught and handled by the user, if desired.
; Calling sequence:
;      data = PRES_TEMP_4D_RD(s)
; Input:
;      s : Time index.  If omitted, the default value of s is 0.
; Output:
;      This function returns a data structure containing variables from the netCDF input file.
; Keywords:
;      None.
; Files:
;      Data are read from the netCDF file 'pres_temp_4d.nc' created by PRES_TEMP_4D.
; Author and history:
;      Kenneth P. Bowman.  2007-02-10.  Visit http://idl.tamu.edu/ for more information.
;      Copyright 2007 Kenneth P. Bowman.
;      See the UNIDATA netCDF copyright file for conditions of use.
;-

COMPILE_OPT IDL2                                    ;Set compile options

IF (N_PARAMS() EQ 0) THEN s = 0                     ;Default time index

s0 = LONG(s)                                        ;Ensure time index is LONG

file_name = 'pres_temp_4d.nc'                       ;Name of file to read

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

NCDF_DIMINQ, id, 'longitude', name, nx              ;Get longitude dimension size
NCDF_DIMINQ, id, 'latitude',  name, ny              ;Get latitude dimension size
NCDF_DIMINQ, id, 'level',     name, nz              ;Get level dimension size
NCDF_DIMINQ, id, 'time',      name, nt              ;Get time dimension size

IF ((s0 LT 0) OR (s0 GT (nt-1))) THEN BEGIN         ;Check time index
   MESSAGE, 'Time index s = ' + STRTRIM(s0, 2) + $
      ' is out of range.', /INFORMATIONAL
   RETURN, -1                      
ENDIF

NCDF_VARGET, id, 'pressure',    values, $           ;Read pressure from file
   OFFSET = [0, 0, 0, s0], COUNT = [nx, ny, nz, 1]
NCDF_ATTGET, id, 'pressure',    'units', units      ;Read pressure units attribute
pressure    = {name   : 'pressure',     $           ;Create pressure data structure
               values : REFORM(values), $
               units  : STRING(units)}

NCDF_VARGET, id, 'temperature', values, $           ;Read temperature from file
   OFFSET = [0, 0, 0, s0], COUNT = [nx, ny, nz, 1]
NCDF_ATTGET, id, 'temperature', 'units', units      ;Read temperature units attribute
temperature = {name   : 'temperature',  $           ;Create temperature data structure
               values : REFORM(values), $
               units  : STRING(units)}

NCDF_CLOSE, id                                      ;Close netCDF input file

RETURN, {longitude   : longitude,   $               ;Return data structure with all variables
         latitude    : latitude,    $
         pressure    : pressure,    $
         temperature : temperature, $
         s           : s0           }

END

