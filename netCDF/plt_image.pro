;--------------------------------------------------------------
; Description: Simple data image plot with basic colortable.
;              Uses updated 8.x syntax for plotting objects.
;--------------------------------------------------------------
;pro plt_image

fname = 'ncFiles/MERRA300.prod.assim.20050101.1x1.25.nc'
ncfid = NCDF_OPEN(fname)

; get the dimension information
;------------------------------
NCDF_VARGET, ncfid, 'lat', lats
NCDF_VARGET, ncfid, 'lon', lons
NCDF_VARGET, ncfid, 'lev', levs
NCDF_VARGET, ncfid, 'time', tims   ; minutes since 2005-01-01 00:00:00

nlats = N_ELEMENTS(lats)
nlons = N_ELEMENTS(lons)
nlevs = N_ELEMENTS(levs)
ntims = N_ELEMENTS(tims)

; Get the temperature data
;-------------------------
NCDF_VARGET, ncfid, 'T', TempK

NCDF_CLOSE, ncfid

; Configure 
xsize = 768
ysize = 525

; Extract the specified level for this timestep
;----------------------------------------------
timestep = 0
lev = 62    ; for vertical level to plot (72 = surface)
T1 = TempK(*,*,lev, timestep)

; Set 11 contour levels
numLevels = 11
minT = MIN(TempK(*,*,lev,0), MAX=maxT)
levels = FINDGEN(numlevels)/(numlevels-1)*(maxT-minT)+minT
PRINT, levels

; Create a title that updates with timestep
hour = tims[timestep] / 60
strHour = STRCOMPRESS((STRING(hour) + ':00'), /REMOVE_ALL)
myTitle = 'Surface Temperature at 2005-01-01 ' + strHour 

iplot = IMAGE(T1, lons, lats, DIMENSIONS=[xsize,ysize], $
        TITLE=myTitle, RGB_TABLE=34, $
        POSITION=[.05, .05, .88, .94])
        
; Overlay outline of continents 
mc = MAPCONTINENTS()

; Setup colorbar 
tick_labels = [STRTRIM(FIX(levels), 2)]
c = COLORBAR(target=iplot,   POSITION=[.94, .25, .97, .75], $
    ORIENTATION=1,TICKLEN=1, MAJOR=numLevels, $
    MINOR=0, TICKNAME = tick_labels)

end
