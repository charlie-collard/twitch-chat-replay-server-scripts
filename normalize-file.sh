gunzip --stdout content/videos/$1 | jq '{video} + .' | gzip - > content/videos2/$1
