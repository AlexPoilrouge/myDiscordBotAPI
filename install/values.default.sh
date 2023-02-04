export LOCAL_SCRIPT_DIR="$( realpath "$( dirname $0 )" )"
export ROOT_DIR="$( realpath ${LOCAL_SCRIPT_DIR}/.. )"


export CONFIG_API_HOST="localhost:6767"
export CONFIG_API_BASE_PATH="/"
export CONFIG_API_HAS_HTTPS="false"

export BOT_DISCORD_TOKEN=""
export BOT_DISCORD_STRASH_INVIT="wJsCfeKF7m"

export TEMPLATE_SRC_CONFIG_API="config.json.template"
export TEMPLATE_DEST_CONFIG_API="${ROOT_DIR}/config/config.json"




export BOT_API_SERVICE_USER="strashbot"
export BOT_API_SERVICE_WORKDIR="${ROOT_DIR}"

export TEMPLATE_SRC_BOT_API_SERVICE="bot-api.service.template"
export TEMPLATE_DEST_BOT_API_SERVICE="/etc/systemd/system/bot-api.service"


export BOT_API_ACCESS_ADDR="127.0.0.1"
export BOT_API_ACCESS_PORT="6029"
export BOT_API_ACCESS_SERVER_NAMES="localhost www.localhost"

export TEMPLATE_SRC_BOT_API_ACCESS="nginx-bot-api.conf.template"
export TEMPLATE_DEST_BOT_API_ACCESS="/etc/nginx/sites-enabled/nginx-bot-api.conf"


export TEMPLATES=( "CONFIG_API" "BOT_API_SERVICE" "BOT_API_ACCESS" )
