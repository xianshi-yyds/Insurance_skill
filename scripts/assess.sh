#!/usr/bin/env bash
# assess.sh — 健康评估与用户画像脚本
set -euo pipefail

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

if [ $# -lt 4 ]; then
    echo "Usage: bash assess.sh <年龄> <性别> <职业> <月收入> [既往病史...]"
    exit 1
fi

AGE=$1
GENDER=$2
JOB=$3
INCOME=$4
shift 4
HISTORY="$*"

echo -e "${BLUE}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║           🩺 用户健康与财务画像分析                      ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${YELLOW}👤 基础信息${NC}"
echo "----------------------------------------"
echo "  年龄: $AGE 岁"
echo "  性别: $GENDER"
echo "  职业: $JOB"
echo "  月收入: ¥$INCOME"
echo "  病史: ${HISTORY:-无}"

# 严重既往症检查
SERIOUS_ILLNESSES=("癌" "肿瘤" "冠心病" "心衰" "心梗" "脑梗" "脑出血" "慢阻肺" "呼吸衰竭" "肝硬化" "肝衰竭" "肾病" "帕金森" "阿尔兹海默" "高危结节")
IS_SERIOUS="false"
FOUND_SERIOUS=""
for illness in "${SERIOUS_ILLNESSES[@]}"; do
    if [[ "$HISTORY" == *"$illness"* ]]; then
        IS_SERIOUS="true"
        FOUND_SERIOUS="$FOUND_SERIOUS $illness"
    fi
done

# 指定疾病检查
DESIGNATED_ILLNESSES=("息肉" "结节" "增生" "囊肿" "结石" "痔疮" "肛瘘" "子宫肌瘤" "肺结核")
IS_DESIGNATED="false"
FOUND_DESIGNATED=""
for illness in "${DESIGNATED_ILLNESSES[@]}"; do
    if [[ "$HISTORY" == *"$illness"* ]]; then
        IS_DESIGNATED="true"
        FOUND_DESIGNATED="$FOUND_DESIGNATED $illness"
    fi
done

echo -e "\n${YELLOW}📋 评估结论${NC}"
echo "----------------------------------------"

if [[ "$JOB" == *"消防"* || "$JOB" == *"警察"* || "$JOB" == *"司机"* ]]; then
    echo -e "  职业风险: ${RED}高风险${NC}"
else
    echo "  职业风险: 低/中风险"
fi

if [ "$IS_SERIOUS" = "true" ]; then
    echo -e "  医疗险建议: ${RED}存在严重既往症 ($FOUND_SERIOUS)${NC}"
else
    if [ "$IS_DESIGNATED" = "true" ]; then
        echo -e "  医疗险建议: ${YELLOW}存在一般既往症 ($FOUND_DESIGNATED)${NC}"
    else
        echo -e "  医疗险建议: ${GREEN}健康状况良好${NC}"
    fi
fi

ANNUAL=$((INCOME * 12))
if [ $ANNUAL -ge 200000 ]; then
    echo -e "  资产规划建议: ${GREEN}具备长期储蓄能力${NC}"
elif [ $ANNUAL -ge 100000 ]; then
    echo -e "  资产规划建议: ${YELLOW}具备中期储蓄能力${NC}"
else
    echo "  资产规划建议: 优先基础保障"
fi

# 输出画像数据行
echo "#PROFILE_DATA#|$AGE|$GENDER|$JOB|$INCOME|$IS_SERIOUS|$IS_DESIGNATED|$HISTORY"
