n = 10
x = findgen(n) 
y = randomu(-1L, n) + 10
plot, x, y, yrange=[9.5, 11.5 ]
err = 0.1
errplot, x, y - err , y+err
