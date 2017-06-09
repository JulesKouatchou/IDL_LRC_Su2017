FUNCTION readVariableAttribute, dataset_id, attribute_name

    ; Open the attribute
    attr_id = H5A_OPEN_NAME(dataset_id, attribute_name)

    ; Get the type
    ;attr_type = H5A_GET_TYPE(attr_id)

    ; Read the attribute
    attribute_value = H5A_READ(attr_id)
    ;attribute_value = H5A_READ(attr_id, attr_type)

    ; close all open identifiers
    ;H5A_CLOSE, attr_type
    H5A_CLOSE, attr_id

    RETURN, attribute_value
END

