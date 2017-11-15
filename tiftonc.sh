#!/bin/bash
############################################################################################################
# -*- coding: utf-8 -*-
#Created on Fri Mar 3 09:08:42 2017
#@author: chinmay deval
#######script writes all the tiff files to a netcdf file using CDO functionality ######
##### The example input Tiff file name is as: ETensemble_mm-month-1_2012.02.01.tif #####
############################################################################################################

echo "Listing all extracted files"
ls -al

echo "looping thru all files with extention .tif"
for i in `find . -name "*.tif" -type f`; do
    echo "I do something with the file $i"
    year=$(echo $i | cut -d"_" -f3 | cut -d"." -f1); echo $year
    month=$(echo $i | cut -d"_" -f3 | cut -d"." -f2); echo $month
    day=$(echo $i | cut -d"_" -f3 | cut -d"." -f3); echo $day 	
    
    gdal_translate -of netCDF ETensemble_mm-month-1_$year.$month.$day.tif ETensemble_mm-month-1_$year.$month.$day.nc
    cdo setreftime,2001-01-01,00:00:00 ETensemble_mm-month-1_$year.$month.$day.nc srt_ETensemble_mm-month-1_$year.$month.$day.nc
    cdo setdate,$year-$month-$day srt_ETensemble_mm-month-1_$year.$month.$day.nc sd_ETensemble_mm-month-1_$year.$month.$day.nc    
done
rm srt_*.nc
rm ETensemble_mm*.nc
cdo mergetime sd_*.nc ETensemble_mm-month-1_2003_2012.nc
rm sd_*.nc          
