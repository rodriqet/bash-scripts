#!/bin/bash

saldo=0

mostrar_saldo() {
	zenity --info --text="Tu saldo actual es ${saldo}" --title="Saldo"
}
depositar() {
	cantidad=$(zenity --entry --title="Deposito" --text="Ingresa una cantidad de dinero: " --entry-text="0")

	if [[ ! $cantidad =~ ^[0-9]+$ ]] || (( cantidad <=0 )); then
		zenity --error --text="Por favor, ingresa una cantidad válida" --title="Error"
	else
		saldo=$(( saldo + cantidad ))
		zenity --info --text="Has ingresado ${cantidad}. Tu nuevo saldo es ${saldo}" --title="Operación completada"
	fi
}
retirar() {
	cantidad=$(zenity --entry --title="Retiro" --text="Ingresa una cantidad de dinero: " --entry-text="0")
	if [[ ! $cantidad =~ ^[0-9]+$ ]] || (( cantidad <=0 )); then
                zenity --error --text="Por favor, ingresa una cantidad válida" --title="Error"
	elif (( cantidad > saldo )); then
		zentity --error --text="Error, saldo insuficiente" --title="Error"
	else
		saldo=$((saldo - cantidad))
		zenity --info --text="Has retirado ${cantidad}. Tu nuevo saldo es ${saldo}" --title="Retiro efectuado"
	fi
}

menu() {
	while true; do
		opcion=$(zenity --list --title="BBVLAM" --column="Opciones" \
			"Ver saldo" \
			"Ingresar" \
			"Retirar" \
			"Salir" )

		case $opcion in 
			"Ver saldo")
				mostrar_saldo ;;
			"Ingresar")
				depositar ;;
			"Retirar")
				retirar ;;
			"Salir")
				zenity --info --text="Gracias por usar BBVLAM" --title="Salir"
				exit 0 ;;
			*)
				zenity --error --text="Opcion invalida. Introduzca una opcion correcta" --title="Error" ;;
		esac
	done
}

menu
