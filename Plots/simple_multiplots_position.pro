!p.multi = [0, 2, 2, 0, 0] 

x = findgen(200) * 0.1
plot, x, sin(x)
plot, x, sin(x) * x^2
plot, x, randomu(1, 200) * x, psym=1
plot, x, 4.0 * !pi * x * 0.1, /polar

!p.multi = 0
