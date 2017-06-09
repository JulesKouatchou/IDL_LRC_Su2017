; http://icc.dur.ac.uk/~tt/IDL/myhist.pro
;making a histogram of randomly generated points

;for random numnber you need a seed
iseed=-1234

;how many datapoints?
ndatapoints=100

;how many bins?
nbins=20

;make the data
data=randomn(iseed,ndatapoints)

;make a 'bin' vector of equally spaced centered bins between xmin and xmax
xmin = min(data)
xmax = max(data)
bins = xmin + findgen(nbins)/float(nbins-1)*(xmax-xmin) 

; plot a histogram
plot, bins, histogram(data,min=xmin,max=xmax,nbins=nbins), $
     psym=10,xrange=[-3.5,3.5]
