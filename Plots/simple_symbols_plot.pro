x = findgen(100) * 0.1 - 5.0
y = 1.0 - exp(-(x^2))
title  = '!3CO!D2!N Spectral Absorption Feature!X'
xtitle = '!3Wavenumber (cm!U-1!N)!X'
ytitle = '!3Transmittance!X'
plot, x + 805.0, y, title = title, xtitle = xtitle, $
      ytitle=ytitle
