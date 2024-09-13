#!/bin/bash

# PubMed Abstracts + Papers downloader

# Load data, pre-process, and tokenize the GAP-Replay dataset. 
# Comment out the steps you don't need and adjust the paths as desired.

# 1. Load data: S2ORC + Abstracts and join with metadata from Papers. After this command, 
# - Abstracts with metadata are stored in /data/abstracts-PubMed_metadata.jsonl 
# - Full-text articles with metadata are stored in /data/s2orc-PubMed_metadata.jsonl
# NOTE: You will need to provide your Semantic Scholar API key.  
## DONE
python pubmed/load.py \
       --dataset all \
       --data_path $GAP_DATA_DIR \
       --key_path pubmed/keys.json 
## END DONE

# 2. Deduplication: remove abstracts for which we already have full-text articles
## DONE
# python pubmed/process.py \
#        --deduplicate\
#        --source_path /cb/datasets/language/scratch/mayo/pubmed/abstracts/abstracts-PubMed_metadata.jsonl \
#        # --save_path /cb/datasets/language/scratch/mayo/pubmed/abstracts/abstracts-PubMed_dedup.jsonl
#        --save_path /cb/datasets/language/scratch/mayo/pubmed/s2orc/s2orc-PubMed.jsonl

# # 3. Clean PubMed abstracts and full-text articles
# python pubmed/process.py \
#        --dataset s2orc \
#        --source_path /cb/datasets/language/scratch/mayo/pubmed/s2orc/s2orc-PubMed_metadata.jsonl \
#        --save_path /cb/datasets/language/scratch/mayo/pubmed/s2orc/s2orc-PubMed_processed.jsonl
## 01/28: re-ran and saved to s2orc-PubMed_processed_full_run2.jsonl with 6.8M entries
# 
# python process.py \
#        --dataset abstracts \
#        # --source_path /cb/datasets/language/scratch/mayo/pubmed/abstracts/abstracts-PubMed_dedup.jsonl \
#        --source_path /cb/datasets/language/scratch/mayo/pubmed/abstracts/abstracts-PubMed_metadata_dedup.jsonl \
#        --save_path /cb/datasets/language/scratch/mayo/pubmed/abstracts/abstracts-PubMed_processed.jsonl
## END DONE
# 4. Train-test split for each dataset
python pubmed/process.py \
       --train_test_split \
       --source_path /cb/datasets/language/scratch/mayo/pubmed/s2orc/s2orc-PubMed_processed.jsonl \
       --split_ratio 0.03 \

python pubmed/process.py \
       --train_test_split \
       --source_path /cb/datasets/language/scratch/mayo/pubmed/abstracts/abstracts-PubMed_processed.jsonl \
       --split_ratio 0.03 \

# python pubmed/process.py \
#        --train_test_split \
#        --source_path /data/guidelines.jsonl \
#        --split_ratio 0.05 \
