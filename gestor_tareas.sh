#!/bin/bash

DATA_FILE="tareas.txt"

touch "$DATA_FILE"

mostrar_menu() {
    zenity --list \
        --title="Gestor de Tareas" \
        --text="Selecciona una opción:" \
        --column="Opción" --column="Descripción" \
        1 "Añadir tarea" \
        2 "Ver tareas" \
        3 "Marcar tarea como completada" \
        4 "Eliminar tarea" \
        5 "Salir"
}

añadir_tarea() {
    tarea=$(zenity --entry \
        --title="Nueva tarea" \
        --text="Introduce la descripción de la tarea:")

    if [[ -z "$tarea" ]]; then
        zenity --error --text="La tarea no puede estar vacía."
        return
    fi

    id=$(($(wc -l < "$DATA_FILE") + 1))
    echo "$id|PENDIENTE|$tarea" >> "$DATA_FILE"

    zenity --info --text="Tarea añadida correctamente."
}

ver_tareas() {
    if [[ ! -s "$DATA_FILE" ]]; then
        zenity --info --text="No hay tareas registradas."
        return
    fi

    zenity --text-info \
        --title="Lista de tareas" \
        --width=500 \
        --height=300 \
        --filename="$DATA_FILE"
}

marcar_completada() {
    if [[ ! -s "$DATA_FILE" ]]; then
        zenity --info --text="No hay tareas para modificar."
        return
    fi

    id=$(zenity --entry \
        --title="Completar tarea" \
        --text="Introduce el ID de la tarea completada:")

    if ! [[ "$id" =~ ^[0-9]+$ ]]; then
        zenity --error --text="ID inválido."
        return
    fi

    if ! grep -q "^$id|" "$DATA_FILE"; then
        zenity --error --text="No existe una tarea con ese ID."
        return
    fi

    sed -i "s/^$id|PENDIENTE|/$id|HECHA|/" "$DATA_FILE"
    zenity --info --text="Tarea marcada como completada."
}

eliminar_tarea() {
    if [[ ! -s "$DATA_FILE" ]]; then
        zenity --info --text="No hay tareas para eliminar."
        return
    fi

    id=$(zenity --entry \
        --title="Eliminar tarea" \
        --text="Introduce el ID de la tarea a eliminar:")

    if ! [[ "$id" =~ ^[0-9]+$ ]]; then
        zenity --error --text="ID inválido."
        return
    fi

    if ! grep -q "^$id|" "$DATA_FILE"; then
        zenity --error --text="No existe una tarea con ese ID."
        return
    fi

    sed -i "/^$id|/d" "$DATA_FILE"
    zenity --info --text="Tarea eliminada."
}


while true; do
    opcion=$(mostrar_menu)

    case $opcion in
        1) añadir_tarea ;;
        2) ver_tareas ;;
        3) marcar_completada ;;
        4) eliminar_tarea ;;
        5) exit 0 ;;
        *)
		zenity --error --text="Opcion invalida. Introduzca una opcion correcta" --title="Error" ;;

    esac
done
