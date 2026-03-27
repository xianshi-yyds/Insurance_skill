#!/usr/bin/env bash
# assess.sh — 深度健康与财务需求画像脚本 (全面版)
set -euo pipefail

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

if [ $# -lt 7 ]; then
    echo "Usage: Insurance_skill assess <年龄> <性别> <职业> <月收入> <是否有房贷:y/n> <是否有受赡养人:y/n> <已有保障:社保/商业险/无> [既往病史...]"
    exit 1
fi

AGE=$1
GENDER=$3
JOB=$3
INCOME=$4
HAS_LOAN=$5
HAS_DEPENDENTS=$6
EXISTING=$7
shift 7
HISTORY="$*"

echo -e "${BLUE}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║           🩺 深度健康与家庭财务画像分析                  ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${YELLOW}👤 基础画像${NC}"
echo "----------------------------------------"
echo "  个人：$AGE 岁 / $GENDER / $JOB"
echo "  经济：月收 ¥$INCOME / 房贷 $([ "$HAS_LOAN" = "y" ] && echo -e "${RED}有${NC}" || echo "无") / 赡养 $([ "$HAS_DEPENDENTS" = "y" ] && echo -e "${RED}有${NC}" || echo "无")"
echo "  存量保障：$EXISTING"
echo "  既往史：${HISTORY:-无}"

# 严重既往症检查
SERIOUS_ILLNESSES=("癌" "肿瘤" "冠心病" "心衰" "心梗" "脑梗" "脑出血" "慢阻肺" "呼吸衰竭" "肝硬化" "肝衰竭" "肾病" "帕金森" "阿尔兹海默" "高危结节")
IS_SERIOUS="false"
for illness in "${SERIOUS_ILLNESSES[@]}"; do
    if [[ "$HISTORY" == *"$illness"* ]]; then IS_SERIOUS="true"; break; fi
done

# 指定疾病检查
DESIGNATED_ILLNESSES=("息肉" "结节" "增生" "囊肿" "结石" "痔疮" "肛瘘" "子宫肌瘤" "肺结核")
IS_DESIGNATED="false"
for illness in "${DESIGNATED_ILLNESSES[@]}"; do
    if [[ "$HISTORY" == *"$illness"* ]]; then IS_DESIGNATED="true"; break; fi
done

echo -e "\n${YELLOW}📋 全面风险初步评估${NC}"
echo "----------------------------------------"
if [ "$HAS_LOAN" = "y" ] || [ "$HAS_DEPENDENTS" = "y" ]; then
    echo -e "  责任风险：${RED}高额家庭责任${NC} (建议配置定期寿险/高额重疾)"
else
    echo "  责任风险：低/中度家庭责任"
fi

if [[ "$EXISTING" != *"社保"* ]]; then
    echo -e "  基础空板：${RED}无社保/医保${NC} (急需医疗险补齐底座)"
fi

# 输出画像数据行 (扩展版)
# 格式: #PROFILE_DATA#|AGE|GENDER|JOB|INCOME|IS_SERIOUS|IS_DESIGNATED|HAS_LOAN|HAS_DEPENDENTS|EXISTING|HISTORY
echo "#PROFILE_DATA#|$AGE|$GENDER|$JOB|$INCOME|$IS_SERIOUS|$IS_DESIGNATED|$HAS_LOAN|$HAS_DEPENDENTS|$EXISTING|$HISTORY"
