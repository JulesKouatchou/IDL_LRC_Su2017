n = 50
z = randomu(-100L, n, n)
for i = 0, 4 do z = smooth(z, 15, /edge_truncate)
z = (z - min(z)) * 15000.0 + 100.00 ; total ozone
x = findgen(n) - 100.0              ; longitude
y = findgen(n) + 10.0               ; latitude

levels = [150, 200, 250, 300, 350, 400, 450, 500]
nlevels = n_elements(levels)
ncolors = nlevels + 1
bottom = 1
c_levels = [min(z), levels, max(z)]
c_labels = [0, replicate(1, nlevels), 0]
c_colors = indgen(ncolors) + bottom
loadct, 33, ncolors=ncolors, bottom=bottom
contour, z, x, y, $
         levels=c_levels, c_colors=c_colors, /fill, $
         xstyle=1, ystyle=1, title='Simulated Total Ozone', $
         xtitle='longitude', ytitle='Latitude'
contour, z, x, y,  levels = c_levels, c_labels=c_labels, /overplot
