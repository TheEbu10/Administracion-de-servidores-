#!/bin/bash

echo "Archivos en la papelera:"
ls ~/.papelera
echo "Escribe el nombre del archivo que quieres recuperar:"
read archivo

if test -f ~/.papelera/"$archivo" ; then
    mv ~/.papelera/"$archivo" .
    echo "Archivo recuperado"
else
    echo "El archivo no está en la papelera"
fi
