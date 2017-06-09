PRO sine_plot

myDevice = !D.NAME ; get device in use
set_plot, 'Z'

scrdim = [1400.,700.]
loadct, 0, /SILENT
;!P.Background = 255
;ERASE, 255 
;DEVICE, SET_PIXEL_DEPTH=24  
;DEVICE, SET_RESOLUTION=[scrdim[0],scrdim[1]]  
;DEVICE, DECOMPOSED = 0

  x=findgen(101)*(0.01 * 2.0 * !pi)
  y=sin(x) 
  plot,x,y

pngout = 'filename.png' ; Output file       
 
WRITE_PNG,  pngout, TVRD(TRUE = 1) 
DEVICE, /CLOSE

set_plot, myDevice ; set the initial device

END
