PRO SWITCH_TEST, MONTH, YEAR
  ;- Compute number of days in month, with correct
  ;- accounting for leap years.
  ;- There is a leap year every year divisible by four,
  ;- except for years which are both divisible by 100
  ;- and not divisible by 400
  SWITCH LONG(month) OF
     1 :
     3 :
     5 :
     7 :
     8 :
    10 :
    12 : BEGIN
         numdays = 31
         BREAK
     END
     4 :
     6 :
     9 :
    11 : BEGIN
      numdays = 30
      BREAK
    END
     2 : BEGIN
     if ( ( LONG(year) MOD 4L) EQ 0L) THEN BEGIn
        if ( ( LONG(year) MOD 100L) eq 0L) AND $
           ((LONG(year) MOD 400L) ne 0L) THEN $
           numdays = 28 ELSE numdays = 29
        ENDIF ELSE BEGIN
           numdays = 28
        ENDELSE
        BREAK
     END
    ELSE : MESSAGE, 'Illegal MONTH'
  ENDSWITCH
  PRINT, numdays, month, year, $
  FORMAT =' ("There are ", i2, " days in Month " , i2 , " of Year " , i4)'
END
