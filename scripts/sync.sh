#!/usr/bin/env bash
# sync.sh — 知识库同步脚本
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PLUGINS_DIR="$BASE_DIR/plugins"
KNOWLEDGE_DIR="$BASE_DIR/knowledge"
SCRIPTS_DIR="$BASE_DIR/scripts"

mkdir -p "$KNOWLEDGE_DIR"

echo "开始同步知识库..."

# 遍历 plugins 目录下的 PDF
for pdf in "$PLUGINS_DIR"/*.pdf; do
    [ -e "$pdf" ] || continue
    
    filename=$(basename "$pdf")
    md_name="${filename%.pdf}.md"
    output_md="$KNOWLEDGE_DIR/$md_name"
    
    # 检查是否已存在 MD，或者 PDF 是否更新
    if [ ! -f "$output_md" ] || [ "$pdf" -nt "$output_md" ]; then
        echo "发现新文件或已更新: $filename"
        python3 "$SCRIPTS_DIR/extract_knowledge.py" "$pdf" "$output_md"
    else
        echo "跳过已同步文件: $filename"
    fi
done

echo "同步完成。当前知识库包含 $(ls "$KNOWLEDGE_DIR" | wc -l) 个文档。"
