!P.MULTI = 0
n = 50

; https://www.harrisgeospatial.com/docs/randomu.html
z = randomu(-100L, n, n)

; Smooth the array z with a boxcar average of width 15
; https://harrisgeospatial.com/docs/SMOOTH.html
for i = 0, 4 do z = smooth(z, 15, /edge_truncate)

z = (z - min(z)) * 15000.0 + 100.00  ; total ozone
x = findgen(n) - 100.0               ; longitude
y = findgen(n) + 10.0                ; latitude
levels   = [150, 200, 250, 300, 350, 400, 450, 500]
c_labels = [  0,   1,   0,   1,   0,   1,   0,   1]
contour, z, x, y , levels = levels , c_labels=c_labels
