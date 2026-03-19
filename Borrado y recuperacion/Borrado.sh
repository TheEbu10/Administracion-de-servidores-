#!/bin/bash

mkdir -p ~/.papelera
echo "Escribe el nombre del archivo que quieres eliminar:"
read archivo

if test -f "$archivo" ; then
    mv "$archivo" ~/.papelera/
    echo "Archivo movido a la papelera"
else
    echo "El archivo no existe"
fi
