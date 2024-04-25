#!/usr/bin/env bash

docker pull chacoll/twitch-chat-replay:latest
docker stop twitch-replay
docker run -d --rm --name twitch-replay -p80:80 -p443:443 -v /etc/letsencrypt:/etc/letsencrypt -v /mnt/twitch_chat_data/content:/usr/share/nginx/html/content chacoll/twitch-chat-replay:latest && docker logs -f twitch-replay &> /home/charlie/workspace/twitch-chat-replay/logs/$(date +"%Y-%m-%dT%H%M%S.log") &
