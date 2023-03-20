"""
API retrieves youtube channel information    
"""

import json
from dataclasses import dataclass, field

from fastapi import FastAPI, HTTPException, Response

app = FastAPI()

# youtube channel
@dataclass
class Channel:
    id: str
    name: str
    tags: list[str] = field(default_factory=list)
    description: str = ""


channels: dict[str, Channel] = {}

# read from json file, normally read from database here
with open("channels.json", encoding="utf8") as file:
    channels_raw = json.load(file)
    for channel_raw in channels_raw:
        channel = Channel(**channel_raw)
        channels[channel.id] = channel

# get request at root - health check
@app.get("/")
def read_root() -> Response:
    return Response("The server is running.")


# retrive channel based on id provided
@app.get("/channels/{channel_id}", response_model=Channel)
def read_item(channel_id: str) -> Channel:
    if channel_id not in channels:
        raise HTTPException(status_code=404, detail="Channel not found")
    return channels[channel_id]
