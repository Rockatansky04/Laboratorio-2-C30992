#!/bin/bash

LogDirectorio = "CambiosDict.log"
Directorio = "/home/barry/Downloads"

Monitoreo = $Directorio
$(date) >> $LogDirectorio

inotifywait -m -q -e create -e modify -e delete "$Directorio" | while read Evento
do
 echo "[$(date '+%H:%M:%S')] $Evento" >> "$LogDirectorio"
done