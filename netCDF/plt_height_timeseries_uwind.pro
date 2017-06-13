;---------------------------------------------------------
; Description: Plot the zomal mean height at a given 
;              latitute over time
;---------------------------------------------------------

PRO plt_height_timeseries_uwind
    ref_lat = 40.0
    vName = 'U'
    firstFile = 0

    dataVal = [] ; empty array to store the data

    numRecs = 0

    begDay = 1   ; beginning day
    endDay = 2   ; ending day

    FOR iday = begDay, endDay  DO BEGIN
        ; Set the file name
        fname = 'ncFiles/MERRA300.prod.assim.200501'+STRING(iday, FORMAT='(I2.2)')+'.1x1.25.nc'

        print, 'Read the file: ', fname

        ; Open the file
        ncfid = NCDF_OPEN(fname)
    
        ; Extract dimension information if it is the first file
        ;------------------------------------------------------
        IF (firstFile EQ 0) THEN BEGIN
           NCDF_VARGET, ncfid, 'lat',  lats
           NCDF_VARGET, ncfid, 'lon',  lons
           NCDF_VARGET, ncfid, 'lev',  levs
           NCDF_VARGET, ncfid, 'time', tims
           nlons = (SIZE(lons, /Dimensions))[0]
           nlats = (SIZE(lats, /Dimensions))[0]
           nlevs = (SIZE(levs, /Dimensions))[0]
           ntims = (SIZE(tims, /Dimensions))[0]
    
           ; Identify the index of the reference latitude
           lat_index = Value_Locate(lats, ref_lat)

           firstFile = 1
        ENDIF
    
        ; Read all the time records of the variable
        ; at the reference latitude
        ; var is a 3D array: longitude/levels/time
        ; (actually 4D with latitude with one entry)
        NCDF_VARGET, ncfid, vName, var, $
                     OFFSET = [0, lat_index, 0, 0], $
                     COUNT  = [nlons, 1, nlevs, ntims], $
                     STRIDE = [1, 1, 1, 1]
        ; Close file
        ;-----------
        NCDF_CLOSE, ncfid
    
        ; Determine the zonal mean
        ; temVar is a 2D array: levels/time
        ; (actually 3D with longitude with one entry)
        ;--------------------------------------------
        tempVar = MEAN(var, DIMENSION=1)

        ; print, size(var, /Dimensions)
        ; print, size(tempVar, /Dimensions)
    
        ; Stack all the records in an array
        ;----------------------------------
        For it = 0, ntims-1 Do Begin
           dataVal = [dataVal, tempVar[0,*,it]]
        EndFor
    
        ;print, size(dataVal, /Dimensions)

        ; Determine the total number of records
        ;--------------------------------------
        numRecs = numRecs + ntims
    EndFor
    
    ;SET_PLOT, 'png'
    ;DEVICE, /DECOMPOSED, /COLOR

    figName = 'fig_TimeSeries_'+vname
    
    records = (FINDGEN(numRecs) + 1) * (24.0/ntims)

    num_levels = 6
    step = (Max(dataVal) - Min(dataVal)) / num_levels
    c_levels = IndGen(num_levels) * step + Min(dataVal)
    ncolors = num_levels + 1
    c_colors = indgen(ncolors) + 1
    bottom = 1
    loadct, 33, ncolors=ncolors, bottom=botto
    
    Contour, dataVal, records, levs, XTitle='Time Records (hours)', $
             YTitle='Vertical Levels', Title=vname+' at '+STRING(long(ref_lat))+'^o latitutde', $
             XStyle=1, YStyle=1, Levels = c_levels, c_colors=c_colors

    ;WRITE_PNG, figName+'.png', TVRD(TRUE = 1)
    ;DEVICE, /CLOSE
    
END
