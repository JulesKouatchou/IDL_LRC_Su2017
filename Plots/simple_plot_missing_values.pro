; https://www.harrisgeospatial.com/docs/plot_procedure.html#dg_routines_3604229493_876382

;-----------------------------
; How IDL Treat Missing Values
;-----------------------------

;==========================================================
; The MAX_VALUE and MIN_VALUE keywords to PLOT can be used 
; to create missing data plots wherein bad data values are 
; not plotted. Data values greater than the value of the 
; MAX_VALUE keyword or less than the value of the MIN_VALUE 
; keyword are treated as missing and are not plotted. 
; The following code creates a dataset with bad data values 
; and plots it with and without these keywords:
;==========================================================

; Make a 100-element array where each element is 
; set equal to its index:
A = FINDGEN(100)

; Set 20 random point in the array equal to 400.
; This simulates "bad" data values above the range
; of the "real" data.
A(RANDOMU(SEED, 20)*100)=400

; Set 20 random point in the array equal to -10.
; This simulates "bad" data values below the range
; of the "real" data.
A(RANDOMU(SEED, 20)*100)=-10

; Plot the dataset with the bad values. Looks pretty bad!
PLOT, A

; Plot the dataset, but don't plot any value over 101.
; The resulting plot looks better, but still shows spurious values:
PLOT, A, MAX_VALUE=101

; This time leave out both high and low spurious values.
; The resulting plot more accurately reflects the "real" data:
PLOT, A, MAX_VALUE=101, MIN_VALUE=0
