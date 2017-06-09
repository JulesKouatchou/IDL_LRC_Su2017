function step_function, x, a
    n = n_elements(x)

    ; make a result array the same size as x
    result = replicate(1., n)

    ; identify by array index those 
    ; elements where x is less than a 
    idx = where(x LT a, count)

    ; If there is at least 1 element that is < a, 
    ; set the result to 0
    if count GT 0 then result[idx] = 0
    return, result
end
