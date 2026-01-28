#!/bin/bash


# ============================
# DevHelper.sh
# Asistente de desarrollo y sistema
# ============================

# -------- VARIABLES --------
LOG_FILE="devhelper.log"
USE_COLORS=true

# -------- COLORES --------
if $USE_COLORS; then
    GREEN="\e[32m"
    RED="\e[31m"
    YELLOW="\e[33m"
    BLUE="\e[34m"
    RESET="\e[0m"
else
    GREEN=""
    RED=""
    YELLOW=""
    BLUE=""
    RESET=""
fi

# -------- FUNCIONES GENERALES --------
pause() {
    echo
    read -p "Pulsa ENTER para continuar..."
}

log_action() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

clear_screen() {
    clear
}

# -------- MENú PRINCIPAL --------
main_menu() {
    clear_screen
    echo "============================="
    echo "        DEVHELPER.SH"
    echo "============================="
    echo "1. Utilidades de desarrollo"
    echo "2. Información del sistema"
    echo "3. Menú de ayuda de comandos"
    echo "4. Extras"
    echo "5. Salir"
    echo
    read -p "Elige una opción: " option

    case $option in
        1) dev_menu ;;
        2) system_menu ;;
        3) help_menu ;;
        4) extra_menu ;;
        5) exit_program ;;
        *) echo -e "${RED}Opción no válida${RESET}"; pause ;;
    esac
}



dev_menu() {
    clear_screen
    echo "--- Utilidades de desarrollo ---"
    echo "1. Comprobar herramientas instaladas"
    echo "2. Git Helper"
    echo "3. Compilar / ejecutar proyecto simple"
    echo "4. Volver"
    echo
    read -p "Elige una opción: " option

    case $option in
        1) check_tools ;;
        2) git_helper ;;
        3) run_project ;;
        4) return ;;
        *) echo "Opción no válida"; pause ;;
    esac
}



check_tools() {
    clear_screen
    echo "Comprobando herramientas..."
    command -v java >/dev/null && echo "Java ✔" || echo "Java ❌"
    command -v git >/dev/null && echo "Git ✔" || echo "Git ❌"
    command -v node >/dev/null && echo "Node ✔" || echo "Node ❌"

    log_action "Comprobación de herramientas"
    pause
}



git_helper() {
    clear_screen
    echo "--- Git Helper ---"
    echo "1. Inicializar repositorio"
    echo "2. Ver estado"
    echo "3. Añadir todo y commit"
    echo "4. Ver ramas"
    echo "5. Volver"
    read -p "Opción: " option

    case $option in
        1) git init ;;
        2) git status ;;
        3)
            read -p "Mensaje de commit: " msg
            git add .
            git commit -m "$msg"
            ;;
        4) git branch ;;
        5) return ;;
        *) echo "Opción no válida" ;;
    esac

    log_action "Uso de Git Helper"
    pause
}



run_project() {
    clear_screen
    echo "1. Compilar Java"
    echo "2. Ejecutar script Bash (debes tener permisos de ejecución)"
    echo
    read -p "Opción: " option

    case $option in
        1)
            read -p "Archivo .java: " file
            javac "$file"
            ;;
        2)
            read -p "Archivo .sh: " file
            bash "$file"
            ;;
        *) echo "Opción no válida" ;;
    esac

    pause
}



system_menu() {
    clear_screen
    echo "--- Información del sistema ---"
    echo "1. Espacio en disco"
    echo "2. Uso de memoria"
    echo "3. Procesos activos"
    echo "4. Información del usuario"
    echo "5. Estado del sistema"
    echo "6. Volver"
    read -p "Opción: " option

    case $option in
        1) df -h ;;
        2) free -h ;;
        3) ps -u "$USER" ;;
        4) whoami; echo "$HOME"; echo "$SHELL" ;;
        5) uptime ;;
        6) return ;;
        *) echo "Opción no válida" ;;
    esac

    pause
}



help_menu() {
    clear_screen
    echo "--- Ayudas rápidas ---"
    echo "1. Comandos Bash"
    echo "2. Comandos Git"
    echo "3. Atajos Linux"
    echo "4. Atajos VS Code"
    echo "5. Volver"
    read -p "Opción: " option

    case $option in
        1) echo "ls, cd, pwd, chmod, grep..." ;;
        2) echo "git clone, add, commit, push..." ;;
        3) echo "Ctrl+C, Ctrl+Z, Ctrl+D..." ;;
        4) echo "Ctrl+Shift+P, Ctrl+ ..." ;;
        5) return ;;
        *) echo "Opción no válida" ;;
    esac

    pause
}



extra_menu() {
    clear_screen
    echo "--- Configuración / Extra ---"
    echo "1. Ver historial"
    echo "2. Información del script"
    echo "3. Ruta actual"
    echo "4. Volver"
    read -p "Opción: " option

    case $option in
        1) cat "$LOG_FILE" ;;
        2) echo "DevHelper.sh v1.0 - Autor: Rodrigo Cuesta" ;;
        3) echo "Ruta actual: $(pwd)" ;;
        4) return ;;
        *) echo "Opción no válida" ;;
    esac

    pause
}



exit_program() {
    echo "Saliendo...👋"
    exit 0
}



while true; do
    main_menu
done
