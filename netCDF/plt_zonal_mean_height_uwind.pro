;---------------------------------------------------------
; Plot the zomal mean height
;---------------------------------------------------------

PRO plt_zonal_mean_height_uwind
    vName = 'U'
    fname = 'ncFiles/MERRA300.prod.assim.20050101.1x1.25.nc'

    ; Open the file
    ncfid = NCDF_OPEN(fname)

    NCDF_VARGET, ncfid, 'lat',  lats
    NCDF_VARGET, ncfid, 'lon',  lons
    NCDF_VARGET, ncfid, 'lev',  levs
    NCDF_VARGET, ncfid, 'time', tims
    nlons = (SIZE(lons, /Dimensions))[0]
    nlats = (SIZE(lats, /Dimensions))[0]
    nlevs = (SIZE(levs, /Dimensions))[0]
    ntims = (SIZE(tims, /Dimensions))[0]

    time_rec = ntims - 1

    ; Read one time record of the variable
    NCDF_VARGET, ncfid, vName, var, $
                 OFFSET = [0, 0, 0, time_rec], $
                 COUNT  = [nlons, nlats, nlevs, 1], $
                 STRIDE = [1, 1, 1, 1]

    ; Close file
    ;-----------
    NCDF_CLOSE, ncfid

    ; Determine the zonal mean heght
    ;--------------------------------------------
    var = MEAN(var, DIMENSION=1)

    num_levels = 6
    step = (Max(var) - Min(var)) / num_levels
    c_levels = IndGen(num_levels) * step + Min(var)
    ncolors = num_levels + 1
    c_colors = indgen(ncolors) + 1
    bottom = 1
    loadct, 33, ncolors=ncolors, bottom=botto

    Contour, var, lats, levs, $
             Title='Zonal Mean Height of '+vName, $
             XTitle='Latitude', $
             YTitle='Vertical Levels', $
             XStyle=1, YStyle=1, Levels = c_levels, c_colors=c_colors

END

