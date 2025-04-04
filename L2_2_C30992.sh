#!/bin/bash

read -p "Hola. Ingrese el comando a ejecutar: " Comando

$Comando
Resultado=$?

if [ $Resultado -eq 0 ]; then 
    echo "El comando se ejecutó correctamente..."
else
    echo "Lo siento :(, no funcionó tu comando. Revisa si lo tienes instalado o lo escribiste mal."
fi

Log="MemCPU.log"
echo "Hora CPU Memoria" > "$Log"

Contador=0
NumeroVeces=5
Tiempo=3

while true; do
    Contador=$((Contador + 1))
    Hora=$(date +"%H:%M:%S")  
    
    CPU=$(top -bn1 | awk '/Cpu/ {print $2}')
    RAM=$(free -m | awk '/Mem/ {print $3}')
    
    echo "$Hora $CPU $RAM" >> "$Log" 
    echo "Medición $Contador..." 
    
    if [ "$NumeroVeces" -gt 0 ] && [ "$Contador" -ge "$NumeroVeces" ]; then
        break 
    fi
    
    sleep "$Tiempo"  
done

gnuplot << EOF
set terminal png
set output 'GraficoConsumo.png'
set title 'Uso de CPU y Memoria RAM'
set xlabel 'Tiempo'
set ylabel 'Uso (%)'
set xdata time
set timefmt "%H:%M:%S"
set format x "%H:%M:%S"
plot "$Log" using 1:2 with lines title 'CPU', \
     "$Log" using 1:3 with lines title 'Memoria RAM (MB)'
EOF

echo "El gráfico ha sido generado como GraficoConsumo.png"