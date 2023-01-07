#!/usr/bin/env bash
projectdir="/home/charlie/workspace/twitch-chat-replay"
find $projectdir/content/videos -name \*.json.gz -type f -print0 | xargs -P8 -0 -n1 $projectdir/summarize.sh | jq -s 'map(select(.created_at >= "2016-03-04T09:20:59Z")) | sort_by(.created_at) | reverse' | gzip - > $projectdir/content/vod-summaries.json.gz.tmp && mv $projectdir/content/vod-summaries.json.gz.tmp $projectdir/content/vod-summaries.json.gz
