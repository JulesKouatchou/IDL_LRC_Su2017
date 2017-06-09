
x=findgen(101)*(0.01 * 2.0 * !pi)
plot,x,sin(x)
oplot, x, sin(-x)
oplot, x, sin(x)*cos(x)
