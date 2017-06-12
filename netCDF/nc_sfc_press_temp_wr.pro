PRO NC_sfc_press_temp_wr, CLOBBER = clobber

    ;+
    ; Name:
    ;      SFC_PRES_TEMP_WR
    ; Purpose:
    ;      This program is an IDL version of the netCDF tutorial program SFC_PRES_TEMP_WR.
    ;      It creates a netCDF output file (sfc_pres_temp.nc) and writes two 12 x 6 arrays
    ;      of single-precision floating-point numbers, 'pressure' and 'temperature', 
    ;      to the file, along with coordinate variables 'longitude' and 'latitude'.
    ;
    ;      The output file produced by this program is identical to the sample file:
    ;         http://www.unidata.ucar.edu/software/netcdf/examples/programs/sfc_pres_temp.cdl
    ;
    ;      Error handling is not included in this example program.  NetCDF errors will cause 
    ;      IDL to halt execution and issue an error message.  These errors can
    ;      be caught and handled by the user, if desired.
    ; Calling sequence:
    ;      SFC_PRES_TEMP_WR
    ; Input:
    ;      None.
    ; Output:
    ;      None.
    ; Keywords:
    ;      CLOBBER : If set, overwrite existing output file.
    ; Files:
    ;      Data are written to the netCDF file 'sfc_pres_temp.nc'.
    ; Author and history:
    ;      Kenneth P. Bowman.  2007-02-10.  Visit http://idl.tamu.edu/ for more information.
    ;      Copyright 2007 Kenneth P. Bowman.
    ;      See the UNIDATA netCDF copyright file for conditions of use.
    ;-
    
    COMPILE_OPT IDL2                                             ;Set compile options
    
    file_name  = 'sfc_pres_temp.nc'                              ;Name of file to create
    
    ;      Compute coordinate variables
    
    nx      =     12                                             ;Number of x-coordinates
    xmin    = -125.0                                             ;Minimum longitude
    xmax    =  -70.0                                             ;Maximum longitude
    dx      = (xmax - xmin)/(nx - 1)                             ;Longitude spacing
    x       = xmin + dx*FINDGEN(nx)                              ;Compute x-coordinates
    
    ny      =      6                                             ;Number of y-coordinates
    ymin    =   25.0                                             ;Minimum latitude
    ymax    =   50.0                                             ;Maximum latitude
    dy      = (ymax - ymin)/(ny - 1)                             ;Latitude spacing
    y       = ymin + dy*FINDGEN(ny)                              ;Compute y-coordinates
    
    ;      Compute dependent variables
    
    pressure    = TRANSPOSE(900.0 +      FINDGEN(ny, nx))        ;Create 2-D array of pressure data
    temperature = TRANSPOSE(  9.0 + 0.25*FINDGEN(ny, nx))        ;Create 2-D array of temperature data
    
    ;      Create output file and write data
    
    id  = NCDF_CREATE(file_name, CLOBBER = clobber)              ;Create netCDF output file
    
    yid = NCDF_DIMDEF(id, 'latitude', ny)                        ;Define y-dimension
    xid = NCDF_DIMDEF(id, 'longitude', nx)                       ;Define x-dimension
    
    vid = NCDF_VARDEF(id, 'latitude',     yid,       /FLOAT)     ;Define latitude variable
    vid = NCDF_VARDEF(id, 'longitude',    xid,       /FLOAT)     ;Define longitude variable
    
    vid = NCDF_VARDEF(id, 'pressure',    [xid, yid], /FLOAT)     ;Define pressure variable
    vid = NCDF_VARDEF(id, 'temperature', [xid, yid], /FLOAT)     ;Define temperature variable
    
    NCDF_ATTPUT, id, 'longitude',   'units', 'degrees east'      ;Write longitude units attribute
    NCDF_ATTPUT, id, 'latitude',    'units', 'degrees north'     ;Write latitude units attribute
    NCDF_ATTPUT, id, 'pressure',    'units', 'hPa'               ;Write pressure units attribute
    NCDF_ATTPUT, id, 'temperature', 'units', 'degree_Celsius'    ;Write temperature units attribute
    
    NCDF_CONTROL, id, /ENDEF                                     ;Exit define mode
    
    NCDF_VARPUT, id, 'longitude',   x                            ;Write longitude to file
    NCDF_VARPUT, id, 'latitude',    y                            ;Write latitude to file
    NCDF_VARPUT, id, 'pressure',    pressure                     ;Write pressure to file
    NCDF_VARPUT, id, 'temperature', temperature                  ;Write temperature to file
    
    NCDF_CLOSE, id                                               ;Close netCDF output file
    
END
