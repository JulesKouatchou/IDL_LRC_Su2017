;https://www.unidata.ucar.edu/software/netcdf/examples/programs/simple_xy_rd.pro

FUNCTION NC_simpleExample_rd

+
; Name:
;      SIMPLE_XY_RD
; Purpose:
;      This function is an IDL version of the netCDF tutorial program SIMPLE_XY_RD.
;      It reads a netCDF input file (simple_xy.nc) containing a 12 x 6 array
;      of 32-bit integers.  It is written as a FUNCTION rather than a PROCEDURE
;      to illustrate one way that netCDF access is typically implemented in IDL.
;
;      Note that no type or dimension definitions are required in this example.  
;      Properties of netCDF variables can be read from a netCDF file by using the 
;      appropriate query routines, but in most cases IDL will automatically obtain that 
;      information from the file and dynamically create variables of the necessary type 
;      and size.
;
;      Sample usage:
;
;      IDL> data = simple_xy_rd()
;      IDL> help, data
;      DATA            LONG      = Array[12, 6]
;
;      Error handling is not included in this example program.  NetCDF errors will cause 
;      IDL to halt execution and issue an error message.  These errors can
;      be caught and handled by the user, if desired.
; Calling sequence:
;      data = SIMPLE_XY_RD()
; Input:
;      None.
; Output:
;      This function returns an array containing the data read from the netCDF file.
; Keywords:
;      None.
; Files:
;      Data are read from the netCDF input file 'simple_xy.nc' created by SIMPLE_XY_WR.
; Author and history:
;      Kenneth P. Bowman.  2007-02-10.  Visit http://idl.tamu.edu/ for more information.
;      Copyright 2007 Kenneth P. Bowman.
;      See the UNIDATA netCDF copyright file for conditions of use.
;-

    COMPILE_OPT IDL2                                            ;Set compile options

    file_name = 'simple_xy.nc'                                  ;Default input file name

    id = NCDF_OPEN(file_name)                                   ;Open netCDF input file

    NCDF_VARGET, id, 'data', data                               ;Read variable 'data'

    NCDF_CLOSE, id                                              ;Close netCDF output file

    dims = size(data, /dimensions)
    print, 'Dimensions of data: ', dims

    i = WHERE((data - LINDGEN(N_ELEMENTS(data))) NE 0, count)   ;Check variable contents
    IF (count NE 0) THEN MESSAGE, 'Error reading data.'

    RETURN, data

END
