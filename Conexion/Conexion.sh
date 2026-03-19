#!/bin/bash

interfaces() {
    echo "Interfaces disponibles:"
    ip -o link show | awk -F': ' '{print $2}'
}

estado() {
    echo "Estado:"
    ip link show | grep state
}

cambiar() {
    read -p "Interfaz: " interfaz
    read -p "Estado (up/down): " estado
    ip link set "$interfaz" "$estado"
}

cable() {
    read -p "Interfaz: " interfaz
    dhclient "$interfaz"
}

wifi() {
    echo "Redes disponibles:"
    nmcli dev wifi list
    read -p "SSID: " ssid
    read -p "Password: " pass
    nmcli dev wifi connect "$ssid" password "$pass"
}

estatica() {
    read -p "Interfaz: " interfaz
    read -p "IP: " ip
    read -p "Prefijo" prefijo
    read -p "Gateway: " gw
    ip addr flush dev "$interfaz"
    ip addr add "$ip"/"$mask" dev "$interfaz"
    ip route add default via "$gw"
}

guardar() {
    nmcli connection reload
	exho "Configuaracion guardada"
}

OPTIONS="Interfaces Estado Cambiar Cable WiFi Estatica Guardar Salir"

select opt in $OPTIONS; do

    if [ "$opt" = "Interfaces" ]; then
        interfaces
    elif [ "$opt" = "Estado" ]; then
        estado
    elif [ "$opt" = "Cambiar" ]; then
        cambiar
    elif [ "$opt" = "Cable" ]; then
        cable
    elif [ "$opt" = "WiFi" ]; then
        wifi
    elif [ "$opt" = "Estatica" ]; then
        estatica
    elif [ "$opt" = "Guardar" ]; then
        guardar
    elif [ "$opt" = "Salir" ]; then
        echo "Adios"
        exit 0
    else
        clear
        echo "Opcion invalida"
    fi

done
