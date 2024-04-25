#!/usr/bin/env bash
contentdir="/mnt/twitch_chat_data/content"
projectdir="/home/charlie/workspace/twitch-chat-replay"
find $contentdir/videos -name \*.json.gz -type f -print0 | xargs -P8 -0 -n1 $projectdir/summarize.sh | jq -s 'map(select(.created_at >= "2016-03-04T09:20:59Z")) | sort_by(.created_at) | reverse' | gzip - > $contentdir/vod-summaries.json.gz.tmp && mv $contentdir/vod-summaries.json.gz.tmp $contentdir/vod-summaries.json.gz
