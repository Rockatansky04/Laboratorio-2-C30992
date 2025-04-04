#!/bin/bash

LogDirectorio = "CambiosDict.log"
Directorio = "/home/barry/Downloads"

Monitoreo = $Directorio
$(date) >> $LogDirectorio

inotifywait -m -q -e create -e modify -e delete "$Directorio" | while read Error
do
 echo "[$(date '+%H:%M:%S')] $Error" >> "$LogDirectorio"
done