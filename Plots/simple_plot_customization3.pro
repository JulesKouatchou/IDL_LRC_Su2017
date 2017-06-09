t = findgen(11)    ; time
a = 9.8            ; acceleration due to gravity
v = a * t          ; velocity
x = 0.5 * a * t^2  ; distance

plot, t, x, /nodata, ystyle = 4, $
      xmargin = [10, 10] , xtitle = 'Time (sec) '
axis, yaxis = 0, yrange = [0, 100], /save, $
      ytitle = 'Velocity (meters/sec, solid line)'
oplot, t, v, linestyle = 0
axis, yaxis = 1, yrange = [0, 500], /save, $
      ytitle = 'Distance (meters, dashed line)'
oplot, t, x, linestyle = 2
