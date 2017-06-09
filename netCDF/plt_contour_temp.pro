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
NCDF_VARGET, ncfid, 'T', T

dims = size(T, /dimensions)

NCDF_CLOSE, ncfid

rec = 2     ; for time record
lev = 35    ; for vertical level

; Extract a 2D slice
;-------------------
T1 = T(*,*,lev, rec)

Contour, T1, lons, lats, XTitle='Longitude', $
         YTitle='Latitude', Title='Atmospheric Temperature', $
         XStyle=1, YStyle=1

