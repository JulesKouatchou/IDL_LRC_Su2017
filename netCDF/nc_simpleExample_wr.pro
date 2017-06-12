;https://www.unidata.ucar.edu/software/netcdf/examples/programs/simple_xy_wr.pro

PRO NC_simpleExample_wr

    ;+
    ; Name:
    ;      SIMPLE_XY_WR
    ; Purpose:
    ;      This program is an IDL version of the netCDF tutorial program SIMPLE_XY_WR.
    ;      It creates a netCDF output file (simple_xy.nc) and writes a 12 x 6 array
    ;      of 32-bit integers to the file.
    ;
    ;      Error handling is not included in this example program.  NetCDF errors will cause 
    ;      IDL to halt execution and issue an error message.  These errors can
    ;      be caught and handled by the user, if desired.
    ;
    ;      The output file produced by this program is identical to the sample file:
    ;         http://www.unidata.ucar.edu/software/netcdf/examples/programs/simple_xy.cdl
    ;
    ;      Note that in IDL the first subscript of an array varies fastest in memory.  
    ;      If x and y represent standard spatial coordinates in a right-handed coordinate
    ;      system, it is generally more efficient in IDL to define arrays as z(x,y).
    ; Calling sequence:
    ;      SIMPLE_XY_WR
    ; Input:
    ;      None.
    ; Output:
    ;      None.
    ; Keywords:
    ;      CLOBBER : If set, overwrite existing output file.
    ; Files:
    ;      Data are written to the netCDF file 'simple_xy.nc'.
    ; Author and history:
    ;      Kenneth P. Bowman.  2007-02-10.  Visit http://idl.tamu.edu/ for more information.
    ;      Copyright 2007 Kenneth P. Bowman.
    ;      See the UNIDATA netCDF copyright file for conditions of use.
    ;-

    COMPILE_OPT IDL2                                      ;Set compile options

    file_name = 'simple_xy.nc'                            ;Name of file to create

    ny   = 12                                             ;Size of x-dimension
    nx   =  6                                             ;Size of y-dimension
    data = LINDGEN(ny, nx)                                ;Create 2-D array of dummy data

    id   = NCDF_CREATE(file_name, /CLOBBER)               ;Create netCDF output file

    yid  = NCDF_DIMDEF(id, 'x', nx)                       ;Define y-dimension
    xid  = NCDF_DIMDEF(id, 'y', ny)                       ;Define x-dimension

    vid  = NCDF_VARDEF(id, 'data', [xid, yid], /LONG)     ;Define data variable

    NCDF_CONTROL, id, /ENDEF                              ;Exit define mode

    NCDF_VARPUT, id, 'data', data                         ;Write data to file

    NCDF_CLOSE, id                                        ;Close netCDF output file

END

