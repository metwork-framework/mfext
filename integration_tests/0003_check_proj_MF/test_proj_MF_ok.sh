#!/bin/bash

projinfo --list-crs | grep "Stéréo" > list-crs-MF
diff list-crs-MF list-crs-MF-ref
if [ $? != 0 ]; then
    echo "error in list crs MF"
    rm -f list-crs-MF
    exit 1
fi
rm -f list-crs-MF
