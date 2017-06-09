; http://www.atmos.umd.edu/~gcm/usefuldocs/hdf_netcdf/modread.html

pro modread,filename, variable, variablename,dimvector,fill

    ; filename and variablename must be character strings
    ; variable, dimvector and fill are dummy variables

    ;--- set up strings to recognize useful information ---
    scalestr = 'scale_factor'
    offsetstr = 'add_offset'
    fillstr = '_FillValue'

    ;--- assign file ID ---
    fileID = hdf_sd_start(filename,/read)

    ;--- using fileID and the variable name, --
    ;--- assign variable ID, and extract data -- 
    varindex = hdf_sd_nametoindex(fileID,variablename)
    varID = hdf_sd_select(fileID,varindex)
    hdf_sd_getdata, varID, variable

    ;--- find fillvalue for bad data --
    fillindex = hdf_sd_attrfind(varID,fillstr)
    hdf_sd_attrinfo, varID, fillindex, data=fill

    ;--- find the scale and offset ---
    scaleindex = hdf_sd_attrfind(varID,scalestr)
    hdf_sd_attrinfo, varID, scaleindex, data=scale
    offsetindex = hdf_sd_attrfind(varID,offsetstr)
    hdf_sd_attrinfo, varID, offsetindex, data=offset
    ;print,'scale=',scale,'offset=',offset

    ;--- rescale variable from the integerized set ---
    variable = scale[0]*(temporary(variable)-offset[0])

    ;--- find bad data and set to IDL fill value ---
    bad = where(variable eq fill)
    if (bad[0] ne -1) then variable[bad] = !values.f_NaN

    ;--- get the dimensions vector ---
    hdf_sd_getinfo, varID,  dims=dimvector

    ;--- close data file --
    hdf_sd_endaccess, varID
    hdf_sd_end, fileID

end
