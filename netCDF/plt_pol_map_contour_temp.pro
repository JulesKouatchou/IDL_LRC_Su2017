;--------------------------------------------------------------
; Description: Contour plot and polar map projection.
;--------------------------------------------------------------

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

dims = size(temperature, /dimensions)

NCDF_CLOSE, ncfid

rec = 2     ; for time record
lev = 35    ; for vertical level

; Extract a 2D slice
;-------------------
tempSlice = temperature(*,*,lev, rec)

num_levels = 6
step = (Max(tempSlice) - Min(tempSlice)) / num_levels
mylevels = IndGen(num_levels) * step + Min(tempSlice)

ncolors = num_levels + 1
bottom = 1

c_levels = mylevels
c_labels = REPLICATE(1, num_levels)
c_colors = INDGEN(ncolors) + bottom

center_lat = -90.0
center_lon = 180.0

Map_Set, /Stereographic, center_lat, center_lon, $
         color = 0, Position=[0.1, 0.1, 0.9, 0.8], $
         /Advance, /Continents, /Grid, /Isotropic, $
         /NoErase, /Horizon, /NoBorder

CONTOUR, tempSlice, lons, lats, levels=c_levels, c_colors=c_colors, /Cell_fill, /Overplot

CONTOUR, tempSlice, lons, lats, /Overplot, $
         color = 0, levels=c_levels; , c_labels = c_labels

Map_Grid, Color=1, GLINESTYLE=2
;Map_Grid, /Box_Axes, /No_Grid, Color=2
;Map_Continents, Color=5
MAP_CONTINENTS,/COASTS,color=0,MLINETHICK=2

colorbar, n_levels = num_levels, colors = c_colors, $
          labels = c_levels, levels=c_levels, $
          Position=[0.125, 0.92, 0.95, 0.96]

