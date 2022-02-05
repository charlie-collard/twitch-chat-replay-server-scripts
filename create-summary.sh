projectdir="/home/charlie/workspace/twitch-chat-replay"
parallel $projectdir/summarize.sh ::: $projectdir/content/videos/*.json.gz | jq -s 'map(select(.created_at >= "2016-03-04T09:20:59Z")) | sort_by(.created_at) | reverse' | gzip - > $projectdir/content/vod-summaries.json.gz.tmp && mv $projectdir/content/vod-summaries.json.gz.tmp $projectdir/content/vod-summaries.json.gz
