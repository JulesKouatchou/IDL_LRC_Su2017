
v = findgen(41) * 0.5 - 10.0
x = rebin(v, 41, 41, /sample)
y = rebin(reform(v, 1, 41), 41, 41, /sample)
r = sqrt(x^2 + y^2) + 1.0e-6
z = sin(r) / r
;surface, z, x, y, charsize=1.5

surface, z, x, y, az=60, charsize=1.5
;surface, z, x, y, ax=60, charsize=1.5

