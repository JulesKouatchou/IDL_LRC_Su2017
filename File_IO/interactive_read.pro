PRO interactive_read
    text = ''
    count = 0
    PRINT , ' Enter text (done to quit)'
    REPEAT BEGIN
       READ, text
       count++
    ENDREP UNTIL  (text EQ 'done')
    PRINT, 'Number of lines entered: ', count--
END

