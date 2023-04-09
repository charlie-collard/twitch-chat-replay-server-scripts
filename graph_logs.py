import json
import pandas as pd
import plotly.express as px
from pathlib import Path


logs = []
for file in Path("logs").rglob("*.log"):
    with open(file, "rb") as f:
        logs += f.read().split(b"\n")

logs = [log for log in logs if b"remote_addr" in log and b"twitchId" in log]
logs = [json.loads(log.decode("utf8")) for log in logs]

# assuming your list is named 'my_list'
df = pd.DataFrame(logs)

# convert time_local to datetime
df['time_local'] = pd.to_datetime(df['time_local'], format='%d/%b/%Y:%H:%M:%S %z')

# extract date from time_local
df['date'] = df['time_local'].dt.date

# count unique remote_addr for each date
unique_remote_addrs = df.groupby('date')['remote_addr'].nunique().reset_index(name='count')

# plot bar graph of unique remote_addrs per day
fig = px.bar(unique_remote_addrs, x='date', y='count', labels={'date': 'Date', 'count': 'Number of unique remote_addr'},
             title='Unique remote_addr per day')

#fig.write_html('unique_remote_addrs.html')
