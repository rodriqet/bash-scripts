#!/bin/bash

RECORD_FILE="record_adivinar.txt"

echo "===Juego de Adivinación==="
echo "Adivina el número del 1 al 100"

if [[ -f $RECORD_FILE ]]; then
    read -r mejor_intentos mejor_nombre < $RECORD_FILE
    echo "Record actual: $mejor_intentos intentos, (jugador: $mejor_nombre)"
else
    echo "No hay récord establecido aún."
fi

numero_secreto=$((RANDOM % 100 + 1))

intentos=0
nombre_jugador=""

read -rp "Introduce tu nombre: " nombre_jugador

while true; do

    read -p "Adivina el número del 1 al 100: " intento

    if ! [[ "$intento" =~ ^[0-9]+$ ]]; then
        echo "Error, introduzca un número"
        continue
    fi

    if ((intento < 1 || intento > 100)); then
        echo "Error, el número debe estar entre 1 y 100"
        continue
    fi

    intentos=$((intentos + 1))

    if (( $intento < $numero_secreto)); then
        echo "El número secreto es mayor"
    elif (( $intento > $numero_secreto)); then
        echo "El número secreto es menor"
    else
        echo "¡Correcto!, el número era $numero_secreto 👌"
        echo "Has necesitado $intentos intentos."
        break
    fi

done

if [[ -f $RECORD_FILE ]]; then
    read -r mejor_intentos mejor_nombre < $RECORD_FILE

    if (( intentos < mejor_intentos )); then
        echo "¡Felicidades $nombre_jugador! Has superado el récord anterior de $mejor_intentos intentos."
        echo "$intentos $nombre_jugador" > "$RECORD_FILE"
    else
        echo "No has superado el récord actual de $mejor_intentos intentos (jugador: $mejor_nombre)"
    fi
else
    echo "Primer record creado con: $intentos $nombre_jugador" > "$RECORD_FILE"
fi

echo "FIN DE LA PARTIDA"