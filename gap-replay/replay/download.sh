#!/bin/bash

# Replay data downloader 

python replay/replay.py \
   --keep=0.0004 \
   --out=./dataset/replay.jsonl \
#    --out=/data/replay.jsonl \

# python replay/replay.py --keep=0.0004 --out=./dataset/replay.jsonl