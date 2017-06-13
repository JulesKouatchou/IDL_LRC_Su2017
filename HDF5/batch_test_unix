#!/bin/csh
# Sample batch script to be executed
# as a unix script.

idl <<!HERE
.compile hdf5_simpleExample_wr
.compile hdf5_simpleExample_rd

hdf5_simpleExample_wr
data = hdf5_simpleExample_rd()
print, 'Dimensions of data: ', size(data, \dimensions)
print, 'Min/Max of data:    ', min(data), max(data)

!HERE
exit

