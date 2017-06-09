!p.multi = [0, 2, 2, 0, 0]
x = findgen(200) * 0.1
y = sin(x)
plot, x, sin(x), xrange=[0,13.5]
plot, x, y, xrange=[0,13.5],   xstyle=1
plot, x, y, xrange=[0,13.5],   xstyle=1, $
            yrange=[-2.5,2.5], ystyle=1

!p.multi = 0
