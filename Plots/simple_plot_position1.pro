
window, /free, xsize=640, ysize=512
x = findgen(200) * 0.1
; POSITION=[left,bottom,right,top]
plot, x, sin(x), position=[0.10, 0.10, 0.45, 0.90]
plot, x, cos(x), position=[0.55, 0.10, 0.90, 0.95],  $
      /noerase
