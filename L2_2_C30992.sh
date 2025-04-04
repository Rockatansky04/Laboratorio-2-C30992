#!/bin/bash

read -p "Hola. Ingrese el comando a ejecutar: " Comando

$Comando
Resultado = $?

if [$Resultado -e 0]; then 
 echo "El comando se esta ejecutando... "

fi 
echo "Lo siento :(, no funciono tu comando. Revisa si lo tienes instalado o lo escribiste mal."

CPU=$(top -bn1 | awk '/Cpu/ {print $2}')
RAM=$(free | awk '/Mem/ {print $3}')

echo "Uso de CPU: $CPU%"
echo "Uso de Memoria: $RAM%"
