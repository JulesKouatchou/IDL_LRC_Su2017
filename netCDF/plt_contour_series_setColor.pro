;pro plt_contour_series_setColor

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

lev = 71    ; for vertical level to plot (71 = sfc)

; Set 11 contour levels (for 10 filled-color intervals)
numLevels = 11
minT = MIN(TempK(*,*,lev,*), MAX=maxT)
cLevels = FINDGEN(numLevels)/(numLevels-1)*(maxT-minT)+minT
PRINT, cLevels

; Create step-colortable from built-in colortable 33
ctNum = 33
LOADCT, ctNum, RGB_TABLE=ct
ctIndices = BYTSCL(cLevels[0:numLevels-2])
step_ct = CONGRID(ct[ctIndices, *], 256, 3)
   
; Open the video recorder.
videoFile = 'video_filled_contours.avi'
video = IDLFFVIDEOWRITE(videoFile, FORMAT='avi')

; Configure video
frameRate = 2
xsize = 768
ysize = 525
stream = video.ADDVIDEOSTREAM(xsize, ysize, frameRate)


FOR timestep=0, ntims-1 DO BEGIN

   ; Extract the specified level for this timestep
   ;----------------------------------------------
   Tslice = TempK(*,*,lev, timestep)
   
   ; Create a title that updates with timestep
   hour = tims[timestep] / 60
   strHour = STRCOMPRESS((STRING(hour) + ':00'), /REMOVE_ALL)
   myTitle = 'Atmospheric Temperature at 2005-01-01 ' + strHour 

   cPlot = CONTOUR(Tslice, lons, lats, DIMENSIONS=[xsize,ysize], $
          XTITLE='Longitude', YTITLE='Latitude', TITLE=myTitle, $
          XSTYLE=1, YSTYLE=1, POSITION=[.1, .13, .84, .90],$
          OVERPLOT=1,  /FILL, C_VALUE = cLevels, $ 
          RGB_INDICES=ctIndices, RGB_TABLE=step_ct)
          
   ; Show continent outlines
   mc = MAPCONTINENTS()
   
   ; Setup colorbar with numLevels ticks to make labels line up properly
   tick_labels = [STRTRIM(FIX(cLevels), 2)]
   c = COLORBAR(TARGET=cPlot, TITLE='Temperature ($\deg$ K)', ORIENTATION=1, $
       POSITION=[.94, .25, .97, .75], TICKLEN=0, MAJOR=numLevels, $
       TICKNAME = tick_labels)
   
   ;Add image to video file
   void = video.PUT(stream, cPlot.COPYWINDOW())
   
   ;Clear plot, unless it's the last one
   IF (timestep LT ntims-1) THEN cPlot.DELETE
            
ENDFOR

; Close video stream
video = 0

; display the movie with gimp
spawn, 'animate -delay 100 video_filled_contours.avi'
end
