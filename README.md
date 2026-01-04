# BTA Minecraft Server Docker

[Этот текст на русском](README_RU.md)

Docker image for running a [BTA](https://www.betterthanadventure.net/) (Better Than Adventure) server.

This image does **not** include the server jar itself; it only provides a convenient tool to download and run the server in a container.

## Environment Variables

More details [can be found here](https://bta.miraheze.org/wiki/Setting_up_a_server).

| Variable                               | Original Name                  | Default Value                                                        | Description                                                                                                                        |
| -------------------------------------- | ------------------------------ | -------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| `MC_ALLOW_PARADISE`                    | `allow-paradise`               | `false`                                                              | If true, players can access the "Paradise" dimension. If false, access is blocked.                                                 |
| `MC_AUTOSAVE_INTERVAL`                 | `autosaveInterval`             | `5`                                                                  | Sets the interval in seconds for automatic world saves.                                                                            |
| `MC_ALLOW_NETHER`                      | `allow-nether`                 | `true`                                                               | If true, players can enter the Nether via a portal. If false, Nether access is disabled.                                           |
| `MC_MAX_CHUNKS_SAVED_PER_AUTOSAVE`     | `maxChunksSavedPerAutosave`    | `24`                                                                 | Maximum number of chunks saved per autosave.                                                                                       |
| `MC_LEVEL_NAME`                        | `level-name`                   | `world`                                                              | Name of the world generated when the server starts.                                                                                |
| `MC_WORLD_TYPE`                        | `world-type`                   | `minecraft\:overworld.extended`                                      | Type of world to generate.                                                                                                         |
| `MC_ALLOW_FLIGHT`                      | `allow-flight`                 | `false`                                                              | If true, players can fly (Creative mode or special abilities). If false, flying is disabled.                                       |
| `MC_STATS_TOKEN`                       | `stats-token`                  | `only-enter-a-value-if-you-are-a-registered-server`                  | Token for public BTA Discord server list. Most users do not need to set this. Use only if you want your server to appear publicly. |
| `MC_SERVER_PORT`                       | `server-port`                  | `25565`                                                              | Port on which the server listens for incoming connections.                                                                         |
| `MC_FORCE_SAVE_ALL_CHUNKS_ON_AUTOSAVE` | `forceSaveAllChunksOnAutosave` | `false`                                                              | Force saving all chunks during autosave.                                                                                           |
| `MC_DISABLE_PHOTOMODE`                 | `disable-photomode`            | `false`                                                              | If true, players cannot use the photo mode.                                                                                        |
| `MC_ENABLE_ITEM_CLUMPING`              | `enable-item-clumping`         | `true`                                                               | Automatically merges nearby items into one stack to improve server performance.                                                    |
| `MC_LEVEL_SEED`                        | `level-seed`                   |                                                                      | Seed for world generation. If empty, a random seed is used.                                                                        |
| `MC_UUID_SERVICE`                      | `uuid-service`                 | `https://api.minecraftservices.com/minecraft/profile/lookup/name/%s` | UUID lookup service for player names.                                                                                              |
| `MC_SERVER_IP`                         | `server-ip`                    |                                                                      | IP address to bind the server. Defaults to all available addresses.                                                                |
| `MC_SUMMON_LIMIT`                      | `summon-limit`                 | `10`                                                                 | Maximum number of entities summonable with /summon at once. Increasing may cause instability.                                      |
| `MC_SLEEP_PERCENTAGE`                  | `sleep-percentage`             | `0`                                                                  | Percentage of players required to sleep to skip the night. Default 0 means a single player can skip the night.                     |
| `MC_WHITE_LIST`                        | `white-list`                   | `false`                                                              | If true, only players listed in the whitelist can join. If false, all players can join.                                            |
| `MC_DEFAULT_GAMEMODE`                  | `default-gamemode`             | `survival`                                                           | Default game mode for players: survival or creative.                                                                               |
| `MC_SPAWN_ANIMALS`                     | `spawn-animals`                | `true`                                                               | If true, animals spawn naturally.                                                                                                  |
| `MC_LANGUAGE`                          | `language`                     | `en_US`                                                              | Server language.                                                                                                                   |
| `MC_ONLINE_MODE`                       | `online-mode`                  | `true`                                                               | If true, the server validates that each player has a valid Minecraft account. If false, non-premium accounts can connect.          |
| `MC_PVP`                               | `pvp`                          | `true`                                                               | If true, players can damage each other.                                                                                            |
| `MC_LOGIN_TIMEOUT_TIME`                | `login-timeout-time`           | `90000`                                                              | Timeout for player authentication before disconnect.                                                                               |
| `MC_JOIN_MESSAGE`                      | `join-message`                 |                                                                      | Custom message players see when joining the server.                                                                                |
| `MC_DIFFICULTY`                        | `difficulty`                   | `2`                                                                  | Server difficulty: 0 = peaceful, 1 = easy, 2 = normal, 3 = hard.                                                                   |
| `MC_MAX_PLAYERS`                       | `max-players`                  | `20`                                                                 | Maximum number of players allowed.                                                                                                 |
| `MC_SPAWN_MONSTERS`                    | `spawn-monsters`               | `true`                                                               | If true, monsters spawn naturally.                                                                                                 |
| `MC_VIEW_DISTANCE`                     | `view-distance`                | `10`                                                                 | Maximum player view distance in chunks.                                                                                            |
| `MC_SPAWN_PROTECTION`                  | `spawn-protection`             | `0`                                                                  | Radius around spawn point protected from non-operators.                                                                            |
| `MC_MOTD`                              | `motd`                         | `A Better than Adventure! Server`                                    | Message of the day displayed in server list.                                                                                       |
| `MC_PACKET_DELAY`                      | `packet-delay`                 | `1`                                                                  | Time between sending packets to clients. Lower is faster.                                                                          |
| `MC_OPS`                               |                                |                                                                      | Comma-separated list of server operators, e.g. `MC_OPS="player1,player2"`.                                                         |
| `MC_WHITELIST`                         |                                |                                                                      | Comma-separated whitelist players, e.g. `MC_WHITELIST="player1,player2"`.                                                          |
| `MC_BANNED_IPS`                        |                                |                                                                      | Comma-separated banned IPs, e.g. `MC_BANNED_IPS="192.168.1.1,192.168.1.2"`.                                                        |
| `MC_BANNED_PLAYERS`                    |                                |                                                                      | Comma-separated banned players, e.g. `MC_BANNED_PLAYERS="player1,player2"`.                                                        |
| `JAVA_OPTS`                            |                                | `-Xms512M -Xmx2G`                                                    | Java options for the server process.                                                                                               |

## Running

Example with a bind mount to persist server data:

```bash
docker run -d \
  -v /srv/minecraft-data:/data \
  -p 25565:25565 \
  -e MC_OPS="Admin,Mod1" \
  -e MC_WHITELIST="Player1,Player2" \
  -e JAVA_OPTS="-Xms1G -Xmx2G" \
  alexandrshapkin/bta-server:7.3_04
```

Notes:

* `/srv/minecraft-data` on the host will contain all server data.
* Inside the container, `/data` holds all mutable server files.
* Port 25565 is exposed.
* The image does **not** include the server jar; it will be downloaded automatically on the first container run.

### Docker Compose

```yaml
services:
  minecraft:
    image: alexandrshapkin/bta-server:7.3_04
    ports:
      - "25565:25565"
    volumes:
      - /srv/minecraft-data:/data
    environment:
      MC_OPS: "Admin,Mod1"
      MC_WHITELIST: "Player1,Player2"
      JAVA_OPTS: "-Xms1G -Xmx2G"
    restart: unless-stopped
```

[Docker Hub](https://hub.docker.com/repository/docker/alexandrshapkin/bta-server)
