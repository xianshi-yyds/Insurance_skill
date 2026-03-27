#!/usr/bin/env bash
# bulk_generate.sh — 多样本企划书批量生成工具
set -euo pipefail

BASE_DIR="/Users/xianshi/Downloads/Insurance"
OUTPUT_FILE="$BASE_DIR/multi_profiles_proposals.md"

echo "Generating 5 professional profiles..."

# 清碎旧文件
echo "# 综合保障规划企划书 (5个典型样本汇编)" > "$OUTPUT_FILE"
echo "---" >> "$OUTPUT_FILE"

generate() {
    local title=$1
    local params=$2
    echo -e "\n\n## 📋 样本 $title\n" >> "$OUTPUT_FILE"
    # 模拟画像并生成建议
    local profile=$(bash "$BASE_DIR/scripts/assess.sh" $params | grep "#PROFILE_DATA#" | tail -n 1)
    bash "$BASE_DIR/scripts/recommend.sh" "$profile" >> "$OUTPUT_FILE"
    echo -e "\n---\n" >> "$OUTPUT_FILE"
}

# 1. 新生儿 (0岁) - 关注教育
generate "01: 新生儿 (0岁/女/关注教育与重疾)" "0 女 个体 5000 n n 无 无"

# 2. 互联网精英 (30岁) - 关注压力与房贷
generate "02: 互联网大厂 (30岁/男/高压高贷)" "30 男 互联网大厂 40000 y y 社保 无"

# 3. 中生代支柱 (45岁) - 关注慢病与养老
generate "03: 中年支柱 (45岁/女/关注养老)" "45 女 行政 15000 n y 社保 颈椎病"

# 4. 高风险职业者 (35岁) - 关注意外与就医
generate "04: 货运司机 (35岁/男/高危职业)" "35 男 货运司机 12000 y y 无 无"

# 5. 银发族 (60岁) - 关注康复与资产传承
generate "05: 退休高管 (60岁/男/关注资产传承)" "60 男 高管 30000 n n 商业险 无"

echo "Success! Report generated at: $OUTPUT_FILE"
