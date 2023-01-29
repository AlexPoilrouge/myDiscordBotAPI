export LOCAL_SCRIPT_DIR="$( realpath "$( dirname $0 )" )"
export ROOT_DIR="$( realpath ${LOCAL_SCRIPT_DIR}/.. )"



export BOT_API_SERVICE_USER="strashbot"
export BOT_API_SERVICE_WORKDIR="${ROOT_DIR}"

export BOT_DISCORD_TOKEN="$( cat compose/token.txt || echo "${LOCAL_SCRIPT_DIR}" )"

export TEMPLATE_SRC_BOT_API_SERVICE="bot-api.service.template"
export TEMPLATE_DEST_BOT_API_SERVICE="/etc/systemd/system/bot-api.service"



export CONFIG_API_HOST="localhost"
export CONFIG_API_BASE_PATH="/kart"
export CONFIG_API_HAS_HTTPS="false"

export TEMPLATE_SRC_CONFIG_API="config.json.template"
export TEMPLATE_DEST_CONFIG_API="${ROOT_DIR}/config/config.json"



export TEMPLATES=( "BOT_API_SERVICE" "CONFIG_API" )
