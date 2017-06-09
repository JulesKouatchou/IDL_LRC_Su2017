PRO hello_world2, name, INCLUDE_NAME = include  
    IF (KEYWORD_SET(include) && (N_ELEMENTS(name) NE 0)) THEN BEGIN  
       PRINT, 'Hello World From '+ name   
    ENDIF ELSE PRINT, 'Hello World'  
END  
