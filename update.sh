#!/usr/bin/env bash
set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  rm -rf "$tempdir"
}

tempdir=$(mktemp -d)
comments_dir="/home/charlie/workspace/twitch-chat-replay/content/videos"
funny_moments_dir="/home/charlie/workspace/twitch-chat-replay/content/funny-moments"
source credentials.sh
access_token=$(curl -sS -X POST "https://id.twitch.tv/oauth2/token?client_id=$client_id&client_secret=$client_secret&grant_type=client_credentials&scope=user:read:email" | jq -r .access_token)
downloaded=$(ls "$comments_dir" | sort | sed 's/.json.gz//g')
recent=$(curl -sS -X GET 'https://api.twitch.tv/helix/videos?user_id=14371185&first=100' \
        -H "Authorization: Bearer $access_token" \
        -H "Client-Id: $client_id" | jq -r .data[].id | sort)


echo "Downloading $(comm -13 <(echo "$downloaded") <(echo "$recent") | wc -l) files"
comm -13 <(echo "$downloaded") <(echo "$recent") | xargs -I {} sh -c "echo {}; tcd --output $tempdir --format json --video {} && gzip $tempdir/{}.json && mv $tempdir/{}.json.gz $comments_dir; python3 /home/charlie/workspace/twitch-chat-replay/find-funny-moments.py $comments_dir/{}.json.gz | gzip - > $funny_moments_dir/{}.json.gz"
