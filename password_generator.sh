#!/bin/bash

archivo="passwords.txt"

while true; do

    echo "====Generador de Contraseñas===="
    echo "1. Generar una contraseña"
    echo "2. Salir"
    read -p "Selecciona una opción:" opcion

    case $opcion in
        1)
        read -p "Introduce la longitud de la contraseña (8-32): " longitud
        if [[ ! "$longitud" =~ ^[0-9]+$ ]] || [[ $longitud -lt 8 ]] || [[ $longitud -gt 32 ]]; then
            echo "Error: La longitud debe ser un número entre 8 y 32."
            continue
        fi

        read -rp "¿Incluir mayúsculas? (s/n): " mayusculas
        read -rp "¿Incluir números? (s/n): " numeros
        read -rp "¿Incluir caracteres especiales? (s/n): " especiales

        if [[ "$mayusculas" != "s" && "$numeros" != "s" && "$especiales" != "s" ]]; then
            echo "Error: Debes seleccionar al menos una opción."
            continue
        fi

        # Generar los caracteres que va a tener mi motor de contraseñas
        caracteres="abcdefghijklmnñopqrstuvwxyz"

        if [[ "$mayusculas" == "s" ]]; then
            caracteres+="ABCDEFGHIJKLMNÑOPQRSTUVWXYZ"
        fi
        if [[ "$numeros" == "s" ]]; then
            caracteres+="0123456789"
        fi
        if [[ "$especiales" == "s" ]]; then
            caracteres+="¡!@#$%^&*()-_[]{}<>¿?/"
        fi

        # Generar el motor de contraseñas

        passwords=""

        for (( i=0; i<longitud; i++ )); do
            random=$(( RANDOM % ${#caracteres} ))
            passwords+=${caracteres:$random:1}
        done

        echo "Contraseña generada: $passwords"

        echo "$passwords" >> "$archivo"
        echo "Contraseña guardada en $archivo"

        ;;

        2)
        echo "Saliendo del generador de contraseñas..."
        exit 0
        ;;

        *)
        echo "Opción no válida. Por favor, selecciona 1 o 2."
        ;;
    esac
done