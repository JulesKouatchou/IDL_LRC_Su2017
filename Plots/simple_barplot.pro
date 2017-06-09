
sites = [20, 55, 102, 235, 350]
years = [ ' 1995 ' , ' 1996 ' , ' 1997 ' , ' 1998 ' , ' 1999 ' ]
xtitle = 'Year'
ytitle = 'Number of Sites'
title = 'IDL Web Sites Worldwide'
loadcolors
bar_plot, sites, barnames=years, $
    colors=[1, 2, 3, 4, 5], $
    title=title, xtitle=xtitle, ytitle=ytitle, /outline

