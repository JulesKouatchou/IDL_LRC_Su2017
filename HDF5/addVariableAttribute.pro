PRO addVariableAttribute, dataset_id, attribute_name=name, attribute_value=val

    ; Creates and writes a string attribute and attached it to 
    ; the object reperesented by dataset_id.


    ; Get data type and space
    attr_datatype_id  = H5T_IDL_CREATE(val)
    attr_dataspace_id = H5S_CREATE_SIMPLE(n_elements(val))

    ; Check if the attribute already exists
    has_attr = findVariableAttribute(dataset_id, name)
    
    ; Delete the attribute if it already exists
    if has_attr then h5a_delete, dataset_id, name

    ; Create the attribute
    attr_id = H5A_CREATE(dataset_id, name, attr_datatype_id, attr_dataspace_id)

    ; Write the attribute
    H5A_WRITE, attr_id, val

    ; close all open identifiers
    H5A_CLOSE, attr_id
    H5S_CLOSE, attr_dataspace_id
    H5T_CLOSE, attr_datatype_id
END

