#!/usr/bin/env bash
# recommend.sh — 专业保险建议书 (企划书 + 利益演示版)
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

if [ $# -lt 1 ]; then
    echo "Usage: Insurance_skill recommend \"<DATA>\""
    exit 1
fi

# 解析扩展数据
IFS='|' read -r TAG AGE GENDER JOB INCOME IS_SERIOUS IS_DESIGNATED HAS_LOAN HAS_DEPENDENTS EXISTING U_HISTORY <<< "$(echo "$1" | tr -d '\r')"

# --- 选定参考利益表 (根据年龄匹配相似案例) ---
KNOWLEDGE_DIR="/Users/xianshi/Downloads/Insurance/knowledge"
REF_TABLE=""
if [ "$AGE" -le 5 ]; then
    REF_TABLE="$KNOWLEDGE_DIR/1F_30w_25yr_OYS2.md"
elif [ "$AGE" -le 25 ]; then
    REF_TABLE="$KNOWLEDGE_DIR/12M_20W_25YR_OYS2.md"
else
    REF_TABLE="$KNOWLEDGE_DIR/30F_15w_25yr_OYS2.md"
fi

# --- 企划书封面 ---
echo -e "${BLUE}================================================================${NC}"
echo -e "${BLUE}           📄 保 障 规 划 建 议 书 (Corporate Proposal)          ${NC}"
echo -e "           生成时间: $(date '+%Y-%m-%d %H:%M') | 编号: OYS-$(date '+%s') "
echo -e "${BLUE}================================================================${NC}"

# --- 第一部分：画像背景 ---
echo -e "\n${CYAN}[ 01 / 背景摘要 ]${NC}"
echo -e "----------------------------------------------------------------"
echo -e "  受访对象：${AGE}岁 / ${GENDER}  |  所属行业：${JOB}"
echo -e "  经济杠杆：年收 ¥$((INCOME * 12))  |  $( [ "$HAS_LOAN" = "y" ] && echo "房贷压力：有" || echo "房贷压力：无" )  |  $( [ "$HAS_DEPENDENTS" = "y" ] && echo "赡养责任：有" || echo "赡养责任：无" )"
echo -e "  健康评级：$( [ "$IS_SERIOUS" = "true" ] && echo -e "${RED}非标体 (限制投保)${NC}" || echo -e "${GREEN}标准体 (优质人群)${NC}" )"
echo -e "  已购背景：${EXISTING}"

# --- 第二部分：多维风险评估 ---
echo -e "\n${CYAN}[ 02 / 核心风险评估 Matrix ]${NC}"
echo -e "----------------------------------------------------------------"
if [[ "$JOB" == *"互联网"* || "$JOB" == *"程序员"* || "$JOB" == *"大厂"* ]]; then
    echo -e "  · [职业风险]：互联网高压环境，需重点防范急性重疾及亚健康恶化风险。"
fi
if [ "$HAS_LOAN" = "y" ] || [ "$HAS_DEPENDENTS" = "y" ]; then
    echo -e "  · [责任波动]：具备显著客观债务或赡养责任。需通过高保额对冲收入中断风险。"
fi
echo -e "  · [医疗需求]：当前 ${EXISTING} 情况对创新药及特需部资源的覆盖力亟待加强。"

# --- 第三部分：专属产品模块 ---
echo -e "\n${CYAN}[ 03 / 方案架构规划 ]${NC}"
echo -e "----------------------------------------------------------------"
echo -e "  【方案 A：健康防护】 众民保·2026 尊享版 (年度 ¥600万额度)"
echo -e "     - 特色：0免赔额（重疾）、特需直付、慢病友好看护。"
echo -e "  【方案 B：资产增值】 AIA 爱伴航计划 2 (美元复利系统)"
echo -e "     - 特色：首10年 50% 额外保额赠送，有效对冲房贷/教育压力的黄金十年。"

# --- 第四部分：核心利益演示 (Comprehensive Parameter Listing) ---
echo -e "\n${CYAN}[ 04 / 核心利益及回馈演示 (参数参考) ]${NC}"
echo -e "----------------------------------------------------------------"
echo -e "  | 达到年龄 | 年度终结 | 保证现价 | 预期总退保额 | 预期身故赔偿 |"
echo -e "  | :------- | :------- | :------- | :----------- | :----------- |"

# 动态提取利益表数据 (提取 55, 65, 75, 85 岁的数据)
get_stats() {
    local age=$1
    # 利用 grep 匹配行首年龄
    local line=$(grep -E "^$age " "$REF_TABLE" | head -n 1 || echo "")
    if [ -n "$line" ]; then
        # 读取列: Age(1) Year(2) Prem(3) Guar(4) Bonus(5) TotalSur(6) BasicDeath(7) BonusDeath(8) TotalDeath(9)
        read -a cols <<< "$line"
        printf "  | %-8s | %-8s | %-8s | %-12s | %-12s |\n" "${cols[0]}" "${cols[1]}" "${cols[3]}" "${cols[5]}" "${cols[8]}"
    fi
}

get_stats 55
get_stats 65
get_stats 75
get_stats 85

echo -e "  *注：以上参数基于 $REF_TABLE 样本测算，实际利益以保单载明为准。"

# --- 第五部分：专家建议 ---
echo -e "\n${CYAN}[ 05 / 专家测评结论 ]${NC}"
echo -e "----------------------------------------------------------------"
echo -e "  💡 规划师视角：方案通过【资产锁定】与【医疗特权】两手抓，在守护健康的同时，"
echo -e "                  利用美元复利为您构建了一个‘可成长’的财务安全垫。"
echo -e "  📅 执行建议：3月为政策优惠期，建议尽早建立观察期，确保保障‘即刻起航’。"

echo -e "\n${BLUE}================================================================${NC}"
echo -e "           本建议书仅供参考，不作为最终法律契约凭证。            "
echo -e "${BLUE}================================================================${NC}"
