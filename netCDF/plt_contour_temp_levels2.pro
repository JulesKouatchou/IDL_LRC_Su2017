;--------------------------------------------------------------
; Description: Simple contour plot with contour levels
;              determine from actual values of data.
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

dims = size(temperature, /DIMENSIONS)

NCDF_CLOSE, ncfid

rec = 2     ; for time record
lev = 35    ; for vertical level

; Extract a 2D slice
;-------------------
tempSlice = temperature(*,*,lev, rec)

num_levels = 6
step = (MAX(tempSlice) - MIN(tempSlice)) / num_levels
mylevels = INDGEN(num_levels) * step + MIN(tempSlice)

CONTOUR, tempSlice, lons, lats, XTitle='Longitude', $
         YTitle='Latitude', Title='Atmospheric Temperature', $
         XStyle=1, YStyle=1, Levels=mylevels, $
         C_Labels=Replicate(1, num_levels)
