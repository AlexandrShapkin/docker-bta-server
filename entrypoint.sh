#!/bin/sh
set -eu

DATA_DIR=/data
SERVER_JAR=$DATA_DIR/server.jar
PROPS_FILE=$DATA_DIR/server.properties
TEMPLATE=/opt/minecraft/server.properties.template

if [ ! -f "$SERVER_JAR" ]; then
    if [ -z "${BTA_VERSION:-}" ]; then
        echo "BTA_VERSION is not set"
        exit 1
    fi

    echo "Downloading BTA server version $BTA_VERSION"
    curl -fsSL \
      -o "$SERVER_JAR" \
      "https://github.com/Better-than-Adventure/bta-download-repo/releases/download/${BTA_VERSION}/bta.${BTA_VERSION}.server.jar"
fi

cp "$TEMPLATE" "$PROPS_FILE"

apply_prop() {
    key="$1"
    value="$2"

    if grep -q "^$key" "$PROPS_FILE"; then
        sed -i "s|^$key=.*|$key=$value|" "$PROPS_FILE"
    else
        echo "$key=$value" >> "$PROPS_FILE"
    fi
}

[ -n "${MC_ALLOW_PARADISE:-}" ] && apply_prop allow-paradise "$MC_ALLOW_PARADISE"
[ -n "${MC_AUTOSAVE_INTERVAL:-}" ] && apply_prop autosaveInterval "$MC_AUTOSAVE_INTERVAL"
[ -n "${MC_ALLOW_NETHER:-}" ] && apply_prop allow-nether "$MC_ALLOW_NETHER"
[ -n "${MC_MAX_CHUNKS_SAVED_PER_AUTOSAVE:-}" ] && apply_prop maxChunksSavedPerAutosave "$MC_MAX_CHUNKS_SAVED_PER_AUTOSAVE"
[ -n "${MC_LEVEL_NAME:-}" ] && apply_prop level-name "$MC_LEVEL_NAME"
[ -n "${MC_WORLD_TYPE:-}" ] && apply_prop world-type "$MC_WORLD_TYPE"
[ -n "${MC_ALLOW_FLIGHT:-}" ] && apply_prop allow-flight "$MC_ALLOW_FLIGHT"
[ -n "${MC_STATS_TOKEN:-}" ] && apply_prop stats-token "$MC_STATS_TOKEN"
[ -n "${MC_SERVER_PORT:-}" ] && apply_prop server-port "$MC_SERVER_PORT"
[ -n "${MC_FORCE_SAVE_ALL_CHUNKS_ON_AUTOSAVE:-}" ] && apply_prop forceSaveAllChunksOnAutosave "$MC_FORCE_SAVE_ALL_CHUNKS_ON_AUTOSAVE"
[ -n "${MC_DISABLE_PHOTOMODE:-}" ] && apply_prop disable-photomode "$MC_DISABLE_PHOTOMODE"
[ -n "${MC_ENABLE_ITEM_CLUMPING:-}" ] && apply_prop enable-item-clumping "$MC_ENABLE_ITEM_CLUMPING"
[ -n "${MC_LEVEL_SEED:-}" ] && apply_prop level-seed "$MC_LEVEL_SEED"
[ -n "${MC_UUID_SERVICE:-}" ] && apply_prop uuid-service "$MC_UUID_SERVICE"
[ -n "${MC_SERVER_IP:-}" ] && apply_prop server-ip "$MC_SERVER_IP"
[ -n "${MC_SUMMON_LIMIT:-}" ] && apply_prop summon-limit "$MC_SUMMON_LIMIT"
[ -n "${MC_SLEEP_PERCENTAGE:-}" ] && apply_prop sleep-percentage "$MC_SLEEP_PERCENTAGE"
[ -n "${MC_WHITE_LIST:-}" ] && apply_prop white-list "$MC_WHITE_LIST"
[ -n "${MC_DEFAULT_GAMEMODE:-}" ] && apply_prop default-gamemode "$MC_DEFAULT_GAMEMODE"
[ -n "${MC_SPAWN_ANIMALS:-}" ] && apply_prop spawn-animals "$MC_SPAWN_ANIMALS"
[ -n "${MC_LANGUAGE:-}" ] && apply_prop language "$MC_LANGUAGE"
[ -n "${MC_ONLINE_MODE:-}" ] && apply_prop online-mode "$MC_ONLINE_MODE"
[ -n "${MC_PVP:-}" ] && apply_prop pvp "$MC_PVP"
[ -n "${MC_LOGIN_TIMEOUT_TIME:-}" ] && apply_prop login-timeout-time "$MC_LOGIN_TIMEOUT_TIME"
[ -n "${MC_JOIN_MESSAGE:-}" ] && apply_prop join-message "$MC_JOIN_MESSAGE"
[ -n "${MC_DIFFICULTY:-}" ] && apply_prop difficulty "$MC_DIFFICULTY"
[ -n "${MC_MAX_PLAYERS:-}" ] && apply_prop max-players "$MC_MAX_PLAYERS"
[ -n "${MC_SPAWN_MONSTERS:-}" ] && apply_prop spawn-monsters "$MC_SPAWN_MONSTERS"
[ -n "${MC_VIEW_DISTANCE:-}" ] && apply_prop view-distance "$MC_VIEW_DISTANCE"
[ -n "${MC_SPAWN_PROTECTION:-}" ] && apply_prop spawn-protection "$MC_SPAWN_PROTECTION"
[ -n "${MC_MOTD:-}" ] && apply_prop motd "$MC_MOTD"
[ -n "${MC_PACKET_DELAY:-}" ] && apply_prop packet-delay "$MC_PACKET_DELAY"

if [ -n "${MC_OPS:-}" ]; then
    OPS_FILE=$DATA_DIR/ops.txt
    : > "$OPS_FILE"
    OLD_IFS=$IFS
    IFS=','
    for op in $MC_OPS; do
        op=$(printf '%s' "$op" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')
        [ -n "$op" ] && printf '%s\n' "$op" >> "$OPS_FILE"
    done
    IFS=$OLD_IFS
fi

if [ -n "${MC_WHITELIST:-}" ]; then
    FILE=$DATA_DIR/whitelist.txt
    : > "$FILE"
    OLD_IFS=$IFS
    IFS=','
    for v in $MC_WHITELIST; do
        v=$(printf '%s' "$v" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')
        [ -n "$v" ] && printf '%s\n' "$v" >> "$FILE"
    done
    IFS=$OLD_IFS
fi

if [ -n "${MC_BANNED_IPS:-}" ]; then
    FILE=$DATA_DIR/banned-ips.txt
    : > "$FILE"
    OLD_IFS=$IFS
    IFS=','
    for v in $MC_BANNED_IPS; do
        v=$(printf '%s' "$v" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')
        [ -n "$v" ] && printf '%s\n' "$v" >> "$FILE"
    done
    IFS=$OLD_IFS
fi

if [ -n "${MC_BANNED_PLAYERS:-}" ]; then
    FILE=$DATA_DIR/banned-players.txt
    : > "$FILE"
    OLD_IFS=$IFS
    IFS=','
    for v in $MC_BANNED_PLAYERS; do
        v=$(printf '%s' "$v" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')
        [ -n "$v" ] && printf '%s\n' "$v" >> "$FILE"
    done
    IFS=$OLD_IFS
fi

cd "$DATA_DIR"
exec java $JAVA_OPTS -jar "$SERVER_JAR" --nogui
