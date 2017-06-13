;--------------------------------------------
; Description: Plot a sub lat/lon domain at 
;              a given level
;--------------------------------------------

PRO plt_subdomain_uwind
    vName = 'U'
    fname = 'ncFiles/MERRA300.prod.assim.20050101.1x1.25.nc'

    ; longitudes run from -180.0 to 180.0
    ; latitudes  run from -90.0 to 90.0

    ref_level = 35
    ref_time  = 2

    ; Area of interest
    min_lon = -20.0
    max_lon = 120.0
    min_lat = -30.0
    max_lat = 40

    ; Open the file
    ncfid = NCDF_OPEN(fname)
    
    ; Extract dimension information
    ;------------------------------
    NCDF_VARGET, ncfid, 'lat',  lats
    NCDF_VARGET, ncfid, 'lon',  lons

    imin_lat = Value_Locate(lats, min_lat)
    imax_lat = Value_Locate(lats, max_lat)
    imin_lon = Value_Locate(lons, min_lon)
    imax_lon = Value_Locate(lons, max_lon)

    lons  = lons[imin_lon:imax_lon]
    lats  = lats[imin_lat:imax_lat]

    nlons = imax_lon - imin_lon + 1
    nlats = imax_lat - imin_lat + 1
    
    ; Read one time record of the variable
    NCDF_VARGET, ncfid, vName, var, $
                 OFFSET = [0, 0, ref_level, ref_time], $
                 COUNT  = [nlons, nlats, 1, 1], $
                 STRIDE = [1, 1, 1, 1]
    ; Close file
    ;-----------
    NCDF_CLOSE, ncfid

    print, size(var, /Dimensions)
    
    ;SET_PLOT, 'png'
    ;DEVICE, /DECOMPOSED, /COLOR

    figName = 'fig_subdomain_'+vname
    
    num_levels = 6
    step = (Max(var) - Min(var)) / num_levels
    c_levels = IndGen(num_levels) * step + Min(var)
    ncolors = num_levels + 1
    c_colors = indgen(ncolors) + 1
    bottom = 1
    loadct, 33, ncolors=ncolors, bottom=bottom
    
    Contour, var, lons, lats, $
             levels=c_levels, c_colors=c_colors, /fill, $
             XTitle='Longitude', $
             YTitle='Latitude', Title='Contour plot of '+vname, $
             XStyle=1, YStyle=1, $
             Position=[0.125, 0.20, 0.95, 0.7]

    colorbar, n_levels = num_levels, colors = c_colors, $
              labels = c_levels, levels=c_levels, $
              Position=[0.125, 0.92, 0.95, 0.96]

    ;WRITE_PNG, figName+'.png', TVRD(TRUE = 1)
    ;DEVICE, /CLOSE
    
END
