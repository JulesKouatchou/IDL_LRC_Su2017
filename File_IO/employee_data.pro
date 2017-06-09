PRO employee_data
    OPENR, lun, 'employee_salary.asc', /Get_Lun

    ;Create variables to hold the name, number of years, and monthly salary.  
    name = '' & years = 0 & salary = FLTARR(12) 

    ;Output a heading for the summary.  
    PRINT, '======================================================' 
    PRINT, FORMAT='("Name", 28X, "Years", 4X, "Yearly Salary")' 
    PRINT, '======================================================' 
 
    ;Loop over each employee.  
    WHILE (~ EOF(lun)) DO BEGIN 
          ;Read the data on the next employee. 
          READF, lun, FORMAT = '(A32,I3,2(/,6F10.2))', name, years, salary 

          ;Output the employee information. Use TOTAL to sum the monthly  
          ;salaries to get the yearly salary. 
          PRINT, FORMAT='(A32,I5,5X,F10.2)', name, years, TOTAL(salary) 
    ENDWHILE 
    Free_Lun, lun 
END 
