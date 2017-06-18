;--------------------------------------------------------------
; Description: Wind vector time series.
;--------------------------------------------------------------

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
NCDF_VARGET, ncfid, 'U', Uwind
NCDF_VARGET, ncfid, 'V', Vwind

dims = SIZE(u, /dimensions)

NCDF_CLOSE, ncfid

lev = 40    ; for vertical level (62 is surface)
period = 0  ; first time period
maxWind = MAX(SQRT(Uwind(*,*,lev,*)^2 + Vwind(*,*,lev,*)^2))
print, 'maxWind = ',maxWind

; Open the video recorder.
video_file = 'video_vectors.avi'
video = IDLFFVIDEOWRITE(video_file, FORMAT='avi')

;configure video
framerate = 2
xsize = 780
ysize = 525
stream = video.ADDVIDEOSTREAM(xsize, ysize, framerate)


FOR period=0, ntims-1 DO BEGIN

   ; Extract data level for this time period
   ;----------------------------------------
   U1 = Uwind(*,*,lev, period)
   V1 = Vwind(*,*,lev, period)
   
   ; Define a subset of the global map with external labels 
   m = MAP('EQUIRECTANGULAR', LIMIT=[10,-170,75,-50], $
       DIMENSIONS=[xsize,ysize], POSITION=[.1, .13, .84, .90], $
       LABEL_POSITION=0, LABEL_ANGLE=0, LINESTYLE="dotted", $
       COLOR='black', /BOX_AXES)

   ; Plot continental outline filled with gray
   cont = MAPCONTINENTS(FILL_COLOR='light gray')
   
   ; Create a title that updates with timestep
   hour = tims[period] / 60
   strHour = STRCOMPRESS((STRING(hour) + ':00'), /REMOVE_ALL)
   myTitle = 'Vector winds (m/s) at 2005-01-01 ' + strHour 

   ; Plot the wind vectors, using /overplot to use the map area defined above
   vec = VECTOR(U1, V1, lons, lats, DIMENSIONS=[xsize,ysize], /OVERPLOT, $
         MIN_VALUE=0, MAX_VALUE=50,  TITLE=myTitle, $
         RGB_TABLE=39, AUTO_COLOR=1, LENGTH_SCALE=1., $
         X_SUBSAMPLE=2, Y_SUBSAMPLE=2)  ; /AUTO_SUBSAMPLE, (spaced too widely)

   ; Add colorbar to show windspeed key
   c = COLORBAR(TARGET=vec, ORIENTATION=1, $
       POSITION=[.91, .25, .94, .75])
   
   ;Save plot to *.png
   plotFilename = STRCOMPRESS(("WindVectors" + strHour + ".png"), /REMOVE_ALL)
   vec.SAVE, plotFilename, RESOLUTION=100
   
   ;Add image to video file 
   void = video.PUT(stream, vec.COPYWINDOW())
               
ENDFOR

; Close video file
video = 0

; Display the movie with GIMP animate
SPAWN, 'animate -delay 100 video_vectors.avi'
end
