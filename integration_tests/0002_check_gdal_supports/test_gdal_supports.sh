#!/bin/bash

ogrinfo list > gdal_supports
for support in PostgreSQL netCDF JPEG2000 JP2OpenJPEG SQLite GeoJSON; do
    grep ${support} gdal_supports >/dev/null
    if [ $? != 0 ]; then
        echo "${support} support is missing in GDAL"
        rm -f gdal_supports
        exit 1
    fi
done
rm -f gdal_supports
