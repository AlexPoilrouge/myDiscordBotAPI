#!/bin/bash

echoerr() { echo "$@" 1>&2; }

SCRIPT_DIR="$( realpath "$( dirname $0 )" )"

PROJECT_ROOT_DIR="$( realpath "${SCRIPT_DIR}/.." )"

TEMPLATES_FILES_DIR="${PROJECT_ROOT_DIR}/install/templates"

VALUES_SCRIPT="${PROJECT_ROOT_DIR}/install/values.default.sh"


if [ -f "$1" ]; then
    VALUES_SCRIPT="$( realpath "$1" )"
elif [ -d "$1" ] && [ -f "$1/values.sh" ]; then
    VALUES_SCRIPT="$( realpath "$1/values.sh" )"
elif [ -f "${SCRIPT_DIR}/values.sh" ]; then
    VALUES_SCRIPT="${SCRIPT_DIR}/values.sh"
elif [ -f "${PROJECT_ROOT_DIR}/values.sh" ]; then
    VALUES_SCRIPT="${PROJECT_ROOT_DIR}/values.sh"
elif ! [ -f "${VALUES_SCRIPT}" ]; then
    echoerr 'No available value file…'
    exit 1
fi


echo "Using install config value script: ${VALUES_SCRIPT}"

subst_in_file(){
    eval "SRC_FILE=\"${TEMPLATES_FILES_DIR}/\${TEMPLATE_SRC_$1}\""
    eval "DEST_FILE=\"\${TEMPLATE_DEST_$1}\""

    if [ -n "${SRC_FILE}" ] && [ -n "${DEST_FILE}" ]; then
        DEST_FILE_DIR="$( realpath "$( dirname "${DEST_FILE}" )" )"
        mkdir -p "${DEST_FILE_DIR}"

        sh -c "envsubst" < "${SRC_FILE}" > "${DEST_FILE}"

        echo "Template '${SRC_FILE}' formed file in '${DEST_FILE}'"

        return 0
    else
        echoerr "No source/destination available for template '$1'"

        return 1
    fi
}

if [ -f "${VALUES_SCRIPT}" ]; then
    if /usr/bin/which source; then
        echo "[source] '${VALUES_SCRIPT}'"
        source "${VALUES_SCRIPT}"
    else
        echo "[.] '${VALUES_SCRIPT}'"
        . "${VALUES_SCRIPT}"
    fi

    if [ -n "${TEMPLATES}" ]; then
        for TPLT in ${TEMPLATES[@]}; do
            subst_in_file "${TPLT}"
        done
    else
        echoerr "No template availabe for install?"
        
        exit 2
    fi

else
    exit 3
fi

if [ -n "${TEMPLATE_DEST_BOT_API_SERVICE}" ] && [ -f "${TEMPLATE_DEST_BOT_API_SERVICE}" ]; then
    which systemctl &> /dev/null && systemctl enable --now "$( basename "${TEMPLATE_DEST_BOT_API_SERVICE}" )"
fi


if [ -n "${TEMPLATE_SRC_BOT_API_ACCESS}" ] && [ -f "${TEMPLATE_DEST_BOT_API_ACCESS}" ]; then
    which systemctl &> /dev/null && which nginx &> /dev/null && systemctl enable --now nginx
fi

exit 0
