;--------------------------------------------------------------
; Description: Use the COARDS convention to produce a file.
;--------------------------------------------------------------
; https://www.unidata.ucar.edu/software/netcdf/examples/programs/pres_temp_4D_wr.pro

pro NC_COARDSconvention_wr

    nlats = 73
    nlons = 96
    nlevs = 22
    ntime = 2

    geo  = FLTARR(nlons, nlats, nlevs)
    timearr = FINDGEN(ntime)*3*60
    lats = 90.0 - FINDGEN(nlats)*2.5
    lons = FINDGEN(nlons)*3.75 - 180.0
    levs = ['1000.', '681.', '464', '316', '215', '100', '68.', '46.', '31.6', $
            '21.50', '14.6', '10.0', '6.81', '4.64', '3.16', '2.15', '1.46',   $
            '1.0'. '0.68', '0.464', '0.316']

    ; Create the netCDF file
    ncFid = NCDF_CREATE('geoPotential.nc', /CLOBBER)

    ; Define the dimensions
    lonid = NCDF_DIMDEF(ncFid, 'longitude', nlons)
    latid = NCDF_DIMDEF(ncFid, 'latitude',  nlats)
    levid = NCDF_DIMDEF(ncFid, 'levels',    nlevs)
    timid = NCDF_DIMDEF(ncFid, 'time',      /UNLIMITED)

    ; Define the variables and set variable attributes
    lonvid  = NCDF_VARDEF(ncFid, 'longitude', [lonid], /FLOAT)
    NCDF_ATTPUT, ncFid, lonvid, 'units', 'degree_ east'

    latvid  = NCDF_VARDEF(ncFid, 'latitude',  [latid], /FLOAT)
    NCDF_ATTPUT, ncFid, latvid, 'units', 'degree_north'

    levvid  = NCDF_VARDEF(ncFid, 'level',     [levid], /FLOAT)
    NCDF_ATTPUT, ncFid, levvid, 'long_name', 'vertical levels'
    NCDF_ATTPUT, ncFid, levvid, 'units', 'hPa'

    timvid  = NCDF_VARDEF(ncFid, 'time', [timid], /SHORT)
    NCDF_ATTPUT, ncFid, timvid, 'long_name', 'time'
    NCDF_ATTPUT, ncFid, timvid, 'units', 'minutes since 2004-12-25 00:00:00'
    NCDF_ATTPUT, ncFid, timvid, 'time_increment', 30000
    NCDF_ATTPUT, ncFid, timvid, 'begin_date', 20041225
    NCDF_ATTPUT, ncFid, timvid, 'begin_time', 0

    geovid  = NCDF_VARDEF(ncFid, 'geopotential', [lonid, latid, levid, timid], /FLOAT)
    NCDF_ATTPUT, ncFid, geovid, 'units',        'm'
    NCDF_ATTPUT, ncFid, geovid, 'long_name',    'Geopotential Height'
    NCDF_ATTPUT, ncFid, geovid, 'scale_factor', 1.0
    NCDF_ATTPUT, ncFid, geovid, '_FillValue',   1.0e15
    NCDF_ATTPUT, ncFid, geovid, 'add_offset',   0.0

    ; Set global attributes
    NCDF_ATTPUT, ncFid, /GLOBAL, 'Title', 'Sample netCDF file'
    NCDF_ATTPUT, ncFid, /GLOBAL, 'Conventions', 'COARDS'

    ; Put the file in data mode
    NCDF_CONTROL, ncFid, /ENDEF

    ; Set the variables
    NCDF_VARPUT, ncFid, timvid, timearr
    NCDF_VARPUT, ncFid, lonvid, lons
    NCDF_VARPUT, ncFid, latvid, lats
    NCDF_VARPUT, ncFid, levvid, levs
    FOR s = 0, ntme-1 DO BEGIN
        NCDF_VARPUT, ncFid, geovid, geo, OFFSET = [0, 0, 0, s], COUNT = [nlons, nlats, nlevs, 1]
    END


    ; Close the file
    NCDF_CLOSE, ncFid

END
