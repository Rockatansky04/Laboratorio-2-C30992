#!/bin/bash

if [ $(id -u ) -ne 0 ]; then 
echo "Se necesita usar root para ejecutar el script" >&2
exit 1

fi 
echo "Buenas :) "

read -p "Ingrese el nombre de usuario: " Nombre
read -p "Ingrese el grupo:" Grupo
read -p "Ingrese la ruta del archivo:" RutaArchivo

if id "$Nombre" &>/dev/null; then
    echo "Bienvenido de nuevo $Nombre" 
else
    sudo useradd "$Nombre"
    if [ $? -eq 0 ]; then
        echo "Su usuario ha sido agregado correctamente"
    else
        echo "Error al agregar el usuario :( "
    fi
fi

if grep -q "^$Grupo:" /etc/group; then 
echo " El grupo $Grupo existe en el sistema"

else
 sudo groupadd "$Grupo"
 echo "El grupo $Grupo a sido creado"
fi

if [ -e "$RutaArchivo" ]; then
 echo "Excelente, la ruta funciona"

else 
 echo "No existe :'("
 exit 1
fi

sudo chown "$Nombre:$Grupo" "$RutaArchivo"
UsuarioArchivo=$(stat -c "%U" "$RutaArchivo")
GrupoArchivo=$(stat -c "%G" "$RutaArchivo")
echo " $RutaArchivo pertenece a el grupo $GrupoArchivo y a el usuario $UsuarioArchivo"

