; https://www.harrisgeospatial.com/docs/finite.html

; To determine which elements of an array are infinity or NaN (Not a Number) values:

A = FLTARR(10)

; Set some values to +/-NaN and positive or negative Infinity:

A[3] = !VALUES.F_NAN
A[4] = -!VALUES.F_NAN
A[6] = !VALUES.F_INFINITY
A[7] = -!VALUES.F_INFINITY

; Find the location of values in A that are positive or negative Infinity:
mask_1 = WHERE(FINITE(A, /INFINITY))
print, mask_1

; Find the location of values in A that are NaN:
mask_2 = WHERE(FINITE(A, /NAN))

; Find the location of values in A that are negative Infinity:
mask_3 = WHERE(FINITE(A, /INFINITY, SIGN=-1))

; Find the location of values in A that are +NaN:
mask_4 = WHERE(FINITE(A, /NAN, SIGN=1))
