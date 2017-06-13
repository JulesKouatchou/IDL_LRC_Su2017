; 
FUNCTION findVariableAttribute, dataset_id, attribute_name, match_index = match_index
    ;--------------------------------------------------------
    ; Description: Inquires if an attribute named 
    ;              attribute_name exists attached to 
    ;              the object dataset_id.
    ;
    ; Input parameters:
    ;   - dataset_id:      identifier of the dataset object
    ;   - attribute_name:  name of the attribute
    ;   - match_index:     index of the attribute (updated here)
    ;
    ; Return Value:  
    ;   - 1: if the attribute was found
    ;   - 0: otherwise.
    ;--------------------------------------------------------

    compile_opt idl2, strictarrsubs

    ; Get the number of attributes
    num_attr = h5a_get_num_attrs(dataset_id)
    
    matched = 0
    match_index = 0
    
    ; Loop over all the attributes
    for i = 0, num_attr-1 do begin

        aid = h5a_open_idx(dataset_id, i)
        
        aname = h5a_get_name(aid)
        
        if aname eq attribute_name then begin
           matched = 1
           match_index = i
           break
        endif
    
    endfor
    
    return, matched

END

