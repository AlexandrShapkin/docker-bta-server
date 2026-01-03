# BTA Minecraft Server Docker

Docker-образ для запуска BTA (Better Than Adventure) сервера..

## Особенности

* Автоматическое скачивание jar из GitHub Releases
* Конфигурация через переменные окружения
* Все изменяемые данные (`world`, `ops.txt`, `whitelist.txt`, `banned-ips.txt`, `banned-players.txt`) хранятся в `/data`
* Настройка JVM через `JAVA_OPTS`

## Переменные окружения

| Переменная          | Описание                                                                       |
| ------------------- | ------------------------------------------------------------------------------ |
| `MC_SERVER_PORT`    | Порт сервера (server.properties)                                               |
| `MC_OPS`            | Никнеймы операторов, через запятую (`Admin,Mod1`)                              |
| `MC_WHITELIST`      | Никнеймы в whitelist, через запятую                                            |
| `MC_BANNED_IPS`     | Список заблокированных IP, через запятую                                       |
| `MC_BANNED_PLAYERS` | Список заблокированных игроков, через запятую                                  |
| `JAVA_OPTS`         | Параметры JVM, например `-Xms2G -Xmx4G`                                        |
| `MC_*`              | Остальные настройки сервера из `server.properties` (поддерживаются аналогично) |

## Запуск

Пример с bind mount для сохранения данных:

```bash
docker run -d \
  -v /srv/minecraft-data:/opt/minecraft \
  -p 25565:25565 \
  -e MC_OPS="Admin,Mod1" \
  -e MC_WHITELIST="Player1,Player2" \
  -e JAVA_OPTS="-Xms1G -Xmx2G" \
  alexandrshapkin/bta-server:7.3_04
```

* `/srv/minecraft-data` на хосте будет содержать все данные сервера.
* Порт пробрасывается из контейнера наружу через `-p`.
