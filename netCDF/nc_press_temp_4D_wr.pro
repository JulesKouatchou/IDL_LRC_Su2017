PRO NC_press_temp_4D_wr, CLOBBER = clobber

    ;+
    ; Name:
    ;      PRES_TEMP_4D_WR
    ; Purpose:
    ;      This program is an IDL version of the netCDF tutorial program PRES_TEMP_4D_WR.
    ;      It creates a netCDF output file (pres_temp_4d.nc) and writes two 12 x 6 x 2 arrays
    ;      of single-precision floating-point numbers, 'pressure' and 'temperature', 
    ;      to the file, along with coordinate variables 'longitude' and 'latitude'.
    ;
    ;      The output file produced by this program is identical to the sample file:
    ;         http://www.unidata.ucar.edu/software/netcdf/examples/programs/pres_temp_4d.cdl
    ;
    ;      Error handling is not included in this example program.  NetCDF errors will cause 
    ;      IDL to halt execution and issue an error message.  These errors can
    ;      be caught and handled by the user, if desired.
    ; Calling sequence:
    ;      PRES_TEMP_4D_WR
    ; Input:
    ;      None.
    ; Output:
    ;      None.
    ; Keywords:
    ;      CLOBBER : If set, overwrite existing output file.
    ; Files:
    ;      Data are written to the netCDF file 'pres_temp_4d.nc'.
    ; Author and history:
    ;      Kenneth P. Bowman.  2007-02-10.  Visit http://idl.tamu.edu/ for more information.
    ;      Copyright 2007 Kenneth P. Bowman.
    ;      See the UNIDATA netCDF copyright file for conditions of use.
    ;-

    COMPILE_OPT IDL2                                                     ;Set compile options

    file_name  = 'pres_temp_4d.nc'                                       ;Name of file to create

    ;      Compute coordinate variables

        nx      =     12                                                     ;Number of x-coordinates
    xmin    = -125.0                                                     ;Minimum longitude
    xmax    =  -70.0                                                     ;Maximum longitude
    dx      = (xmax - xmin)/(nx - 1)                                     ;Longitude spacing
    x       = xmin + dx*FINDGEN(nx)                                      ;Compute x-coordinates
    
    ny      =      6                                                     ;Number of y-coordinates
    ymin    =   25.0                                                     ;Minimum latitude
    ymax    =   50.0                                                     ;Maximum latitude
    dy      = (ymax - ymin)/(ny - 1)                                     ;Latitude spacing
    y       = ymin + dy*FINDGEN(ny)                                      ;Compute y-coordinates
    
    nz      =      2                                                     ;Number of vertical levels
    nt      =      2                                                     ;Number of time steps
    
    ;      Compute dependent variables
    
    pressure    = 900.0 + FINDGEN(nx, ny, nz)                            ;Create 2-D array of pressure data
    temperature =   9.0 + FINDGEN(nx, ny, nz)                            ;Create 2-D array of temperature data
    
    ;      Create output file and write data
    
    ncfid  = NCDF_CREATE(file_name, CLOBBER = clobber)                      ;Create netCDF output file
    
    zid = NCDF_DIMDEF(ncfid, 'level',     nz)                               ;Define z-dimension
    yid = NCDF_DIMDEF(ncfid, 'latitude',  ny)                               ;Define y-dimension
    xid = NCDF_DIMDEF(ncfid, 'longitude', nx)                               ;Define x-dimension
    tid = NCDF_DIMDEF(ncfid, 'time',      /UNLIMITED)                       ;Define t-dimension (unlimited)

    vid = NCDF_VARDEF(ncfid, 'latitude',     yid,       /FLOAT)             ;Define latitude variable
    vid = NCDF_VARDEF(ncfid, 'longitude',    xid,       /FLOAT)             ;Define longitude variable

    vid = NCDF_VARDEF(ncfid, 'pressure',    [xid, yid, zid, tid], /FLOAT)   ;Define pressure variable
    vid = NCDF_VARDEF(ncfid, 'temperature', [xid, yid, zid, tid], /FLOAT)   ;Define temperature variable

    NCDF_ATTPUT, ncfid, 'longitude',   'units', 'degrees east'              ;Write longitude units attribute
    NCDF_ATTPUT, ncfid, 'latitude',    'units', 'degrees north'             ;Write latitude units attribute
    NCDF_ATTPUT, ncfid, 'pressure',    'units', 'hPa'                       ;Write pressure units attribute
    NCDF_ATTPUT, ncfid, 'temperature', 'units', 'degree_Celsius'            ;Write temperature units attribute

    ; Set global attributes
    NCDF_ATTPUT, ncFid, /GLOBAL, 'Title', 'Sample netCDF file'
    NCDF_ATTPUT, ncFid, /GLOBAL, 'Description', 'Attributes and unlimited dim'

    NCDF_CONTROL, ncfid, /ENDEF                                             ;Exit define mode

    NCDF_VARPUT, ncfid, 'longitude',   x                                    ;Write longitude to file
    NCDF_VARPUT, ncfid, 'latitude',    y                                    ;Write latitude to file

    FOR s = 0, nt-1 DO BEGIN                                             ;Time index
        NCDF_VARPUT, ncfid, 'pressure',    pressure, $                       ;Write pressure to file
           OFFSET = [0, 0, 0, s], COUNT = [nx, ny, nz, 1]
        NCDF_VARPUT, ncfid, 'temperature', temperature, $                    ;Write temperature to file
           OFFSET = [0, 0, 0, s], COUNT = [nx, ny, nz, 1]
    ENDFOR

    NCDF_CLOSE, ncfid                                                       ;Close netCDF output file

END

