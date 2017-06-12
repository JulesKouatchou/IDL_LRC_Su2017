fname = 'ncFiles/MERRA300.prod.assim.20050101.1x1.25.nc'

ncfid = ncdf_open(fname)

; get the dimension information
;------------------------------
ncdf_varget, ncfid, 'lat', lats
ncdf_varget, ncfid, 'lon', lons
ncdf_varget, ncfid, 'lev', levs
ncdf_varget, ncfid, 'time', tims   ; minutes since 2005-01-01 00:00:00

nlats = n_elements(lats)
nlons = n_elements(lons)
nlevs = n_elements(levs)
ntims = n_elements(tims)

; Get the temperature data
;-------------------------
ncdf_varget, ncfid, 'U', Uwind
ncdf_varget, ncfid, 'V', Vwind

dims = size(u, /dimensions)

ncdf_close, ncfid

lev = 40    ; for vertical level (62 is surface)
period = 0  ; first time period
maxWind = max(sqrt(Uwind(*,*,lev,*)^2 + Vwind(*,*,lev,*)^2))
print, maxWind

; Open the video recorder.
video_file = 'video_vectors.avi'
video = idlffvideowrite(video_file, format='avi')

;configure video
framerate = 2
xsize = 780
ysize = 525
stream = video.addvideostream(xsize, ysize, framerate)


FOR period=0, ntims-1 DO BEGIN
   ; Extract a 2D slice
   ;-------------------
   U1 = Uwind(*,*,lev, period)
   V1 = Vwind(*,*,lev, period)
   
   m = map('equirectangular', limit=[10,-170,75,-50], $
       dimensions=[xsize,ysize], position=[.1, .13, .84, .90], $
       label_position=0, label_angle=0, $
       color='light gray', label_color='black')

   cont = mapcontinents(fill_color='light gray')
   
   ; Create a title that updates with timestep
   hour = tims[period] / 60
   strHour = strcompress((string(hour) + ':00'), /remove_all)
   myTitle = 'Vector winds (m/s) at 2005-01-01 ' + strHour 

   vec = vector(U1, V1, lons, lats, dimensions=[xsize,ysize], /overplot, $
         min_value=0, max_value=50,  title=myTitle, $
         rgb_table=39, auto_color=1, length_scale=1., $
         x_subsample=2, y_subsample=2)  ;/auto_subsample, 

   c = colorbar(target=vec, orientation=1, $
       position=[.94, .25, .97, .75])
   
   ;Save plot to *.png
   plotFilename = strcompress(("WindVectors" + strHour + ".png"), /remove_all)
   vec.save, plotFilename, resolution=100
   
   ;Add image to video file 
   void = video.put(stream, vec.copywindow())
   
   ;Clear plot, unless it's the last one
   if (period LT ntims-1) then vec.delete
            
ENDFOR

video = 0

; Display the movie with GIMP animate
spawn, 'animate -delay 100 video_vectors.avi'
end
