import sys
import gzip
import json
import pandas as pd
from datetime import datetime, timedelta

large_bucket = 3

with gzip.open(sys.argv[1]) as f:
    comments = json.load(f)["comments"]

timestamps = list(map(lambda x: datetime.fromisoformat("1970-01-01T00:00:00") + timedelta(seconds=x["content_offset_seconds"]), comments))
bodies = list(map(lambda x: x["message"]["body"], comments))

df = pd.DataFrame.from_dict({"timestamp": timestamps, "body": bodies})
df = df.set_index(pd.DatetimeIndex(pd.to_datetime(df["timestamp"])))[["body"]]

jokes = df[df["body"].str.contains("\+2", case=False)]
resampled = jokes.resample(str(large_bucket) + "Min").count()
good_jokes = resampled[resampled["body"] >= 18]

out = []
for joke_timestamp in good_jokes.index:
    sub_range = jokes.loc[joke_timestamp:joke_timestamp+timedelta(minutes=large_bucket)]
    exact_joke_time = sub_range.resample("5S").count().idxmax()["body"]
    out.append((exact_joke_time - timestamps[0] - timedelta(seconds=40)).seconds)
print(json.dumps(out))
