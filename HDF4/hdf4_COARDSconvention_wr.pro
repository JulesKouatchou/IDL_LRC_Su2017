
pro write_HDF

    nlats = 73L
    nlons = 96L
    nlevs = 22L
    ntime = 2L

    geo  = FLTARR(nlons, nlats, nlevs)
    timearr = FINDGEN(ntime)*3*60
    lats = 90.0 - FINDGEN(nlats)*2.5
    lons = FINDGEN(nlons)*3.75 - 180.0
    levs = [1000., 681., 464, 316, 215, 100, 68., 46., 31.6, $
            21.50, 14.6, 10.0, 6.81, 4.64, 3.16, 2.15, 1.46, 1.15,   $
            1.0, 0.68, 0.464, 0.316]

    varName = 'geopotential'

    ;--------------------
    ; Create the HDF file
    ;--------------------
    hdfid = HDF_SD_START('geoPotential.hdf', /CREATE)

    geovid  = HDF_SD_CREATE(hdfid, varName, [nlons, nlats, nlevs, 0L], /FLOAT)

    HDF_SD_ATTRSET, geovid, 'units',        'm'
    HDF_SD_ATTRSET, geovid, 'long_name',    'Geopotential Height'
    HDF_SD_ATTRSET, geovid, 'scale_factor', 1.0
    HDF_SD_ATTRSET, geovid, '_FillValue',   1.0e15
    HDF_SD_ATTRSET, geovid, 'add_offset',   0.0

    ; Define the variables and set variable attributes
    lonvid  = HDF_SD_DIMGETID(geovid, 0)
    HDF_SD_DIMSET, lonvid, NAME='longitude', UNIT='degree_east', SCALE=lons

    latvid  = HDF_SD_DIMGETID(geovid, 1)
    HDF_SD_DIMSET, latvid, NAME='latitude', UNIT='degree_north', SCALE=lats

    levvid  = HDF_SD_DIMGETID(geovid, 2)
    HDF_SD_DIMSET, levvid, NAME='lev', UNIT='hPa', SCALE=levs
    HDF_SD_ATTRSET, levvid, 'long_name', 'vertical_levels'

    timvid  = HDF_SD_DIMGETID(geovid, 3)
    HDF_SD_DIMSET, timvid, NAME='time'
    HDF_SD_ATTRSET, timvid, 'long_name', 'time'
    HDF_SD_ATTRSET, timvid, 'units', 'minutes since 2004-12-25 00:00:00'
    HDF_SD_ATTRSET, timvid, 'time_increment', 30000
    HDF_SD_ATTRSET, timvid, 'begin_date', 20041225
    HDF_SD_ATTRSET, timvid, 'begin_time', 0

    ; Set global attributes
    HDF_SD_ATTRSET, hdfid, 'Title', 'Sample netCDF file'
    HDF_SD_ATTRSET, hdfid, 'Conventions', 'COARDS'
    HDF_SD_ATTRSET, hdfid, 'Creation_date', systime()

    HDF_SD_ENDACCESS, geovid

    ; Close the file
    HDF_SD_END, hdfid
  

    ;---------------------------
    ; Write the data in the file
    ;---------------------------
    hdfid = HDF_SD_START('geoPotential.hdf', /RDWR)

    index = HDF_SD_NAMETOINDEX(hdfid, varName)
    geovid = HDF_SD_SELECT(hdfid, index)

    ; Set the variables
    FOR s = 0, ntime-1 DO BEGIN
        HDF_SD_ADDDATA, geovid, geo, START = [0, 0, 0, s], COUNT = [nlons, nlats, nlevs, 1]
    END

    HDF_SD_ENDACCESS, geovid

    ; Close the file
    HDF_SD_END, hdfid

END
