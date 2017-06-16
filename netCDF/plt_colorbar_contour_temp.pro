;--------------------------------------------------------------
; Description: Provide and example of ploting the colorbar.
;--------------------------------------------------------------

; File name
fname = 'ncFiles/MERRA300.prod.assim.20050101.1x1.25.nc'

ncfid = NCDF_OPEN(fname)

; Get the dimension information
;------------------------------
NCDF_VARGET, ncfid, 'lat', lats
NCDF_VARGET, ncfid, 'lon', lons
NCDF_VARGET, ncfid, 'lev', levs
NCDF_VARGET, ncfid, 'time', tims

nlats = N_ELEMENTS(lats)
nlons = N_ELEMENTS(lons)
nlevs = N_ELEMENTS(levs)
ntims = N_ELEMENTS(tims)

; Get the temperature data
;-------------------------
NCDF_VARGET, ncfid, 'T', temperature

dims = size(temperature, /DIMENSIONS)

NCDF_CLOSE, ncfid

rec = 2     ; for time record
lev = 35    ; for vertical level

; Extract a 2D slice
;-------------------
tempSlice = temperature(*,*,lev, rec)

num_levels = 6
step = (Max(tempSlice) - Min(tempSlice)) / num_levels
mylevels = INDGEN(num_levels) * step + Min(tempSlice)

ncolors = num_levels + 1
bottom = 1

c_levels = mylevels
c_labels = REPLICATE(1, num_levels)
c_colors = INDGEN(ncolors) + bottom
LOADCT, 33, ncolors=ncolors, bottom=bottom

CONTOUR, tempSlice, lons, lats, $
         levels=c_levels, c_colors=c_colors, /fill, $
         XTitle='Longitude',  YTitle='Latitude', $
         Title='Atmospheric Temperature', $
         XStyle=1, YStyle=1, $
         Position=[0.125, 0.20, 0.95, 0.7]

colorbar, n_levels = num_levels, colors = c_colors, $
          labels = c_levels, levels=c_levels, $
          Position=[0.125, 0.92, 0.95, 0.96]
