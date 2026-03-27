#!/usr/bin/env bash
# recommend.sh — 专业保险建议书 (深度规划企划书)
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
# #PROFILE_DATA#|AGE|GENDER|JOB|INCOME|IS_SERIOUS|IS_DESIGNATED|HAS_LOAN|HAS_DEPENDENTS|EXISTING|HISTORY
IFS='|' read -r TAG AGE GENDER JOB INCOME IS_SERIOUS IS_DESIGNATED HAS_LOAN HAS_DEPENDENTS EXISTING U_HISTORY <<< "$(echo "$1" | tr -d '\r')"

# --- 企划书封面 ---
echo -e "${BLUE}================================================================${NC}"
echo -e "${BLUE}           📄 保 障 规 划 建 议 书 (Corporate Proposal)          ${NC}"
echo -e "           生成时间: $(date '+%Y-%m-%d %H:%M') | 编号: OYS-$(date '+%s') "
echo -e "${BLUE}================================================================${NC}"

# --- 第一部分：画像背景 ---
echo -e "\n${CYAN}[ 01 / 背景摘要 ]${NC}"
echo -e "----------------------------------------------------------------"
echo -e "  受访对象：${AGE}岁 / ${GENDER}性  |  所属行业：${JOB}"
echo -e "  经济杠杆：年收 ¥$((INCOME * 12))  |  $( [ "$HAS_LOAN" = "y" ] && echo "房贷压力：有" || echo "房贷压力：无" )  |  $( [ "$HAS_DEPENDENTS" = "y" ] && echo "赡养责任：有" || echo "赡养责任：无" )"
echo -e "  健康评级：$( [ "$IS_SERIOUS" = "true" ] && echo -e "${RED}非标体 (限制投保)${NC}" || echo -e "${GREEN}标准体 (优质人群)${NC}" )"
echo -e "  已购背景：${EXISTING}"

# --- 第二部分：多维风险评估 ---
echo -e "\n${CYAN}[ 02 / 核心风险评估 Matrix ]${NC}"
echo -e "----------------------------------------------------------------"
# 1. 职业与健康
if [[ "$JOB" == *"互联网"* || "$JOB" == *"程序员"* || "$JOB" == *"大厂"* ]]; then
    echo -e "  · [职业风险]：互联网高压环境，需重点防范急性重疾及亚健康恶化风险。"
fi
# 2. 家庭责任
if [ "$HAS_LOAN" = "y" ] || [ "$HAS_DEPENDENTS" = "y" ]; then
    echo -e "  · [责任波动]：具备显著债务或赡养责任。一旦失去收入能力，家庭现金流将面临断裂压力。"
fi
# 3. 医疗通胀
echo -e "  · [医疗资源]：目前 ${EXISTING} 情况对创新药（CAR-T 等）及特需服务的覆盖力可能存在盲区。"

# --- 第三部分：深度方案设计 ---
echo -e "\n${CYAN}[ 03 / 专属产品体系构建 ]${NC}"
echo -e "----------------------------------------------------------------"

# 医疗模块 (Zhongminbao)
if [ "$IS_SERIOUS" = "true" ]; then
    echo -e "  【方案 A：医疗兜底】 政府惠民保"
    echo -e "     - 匹配逻辑：针对您的既往症 (${U_HISTORY})，此类普惠险是目前唯一的可靠选择。"
else
    echo -e "  【方案 A：医疗屏障】 众民保·2026 尊享版 (特需/国际/VIP)"
    echo -e "     - 核心功能：年度 ¥600万额度，覆盖三甲医院 VIP 部，且重疾 0 免赔。"
    if [ "$IS_DESIGNATED" = "true" ]; then echo -e "     - 透明告知：针对既往项 (${U_HISTORY}) 首年比例折算，次年恢复。保证全流程透明。" ; fi
fi

# 资产与重疾模块 (AIA)
echo -e ""
ANNUAL=$((INCOME * 12))
if [ $ANNUAL -ge 200000 ]; then
    echo -e "  【方案 B：资产锚点】 AIA 爱伴航计划 2 (美元复利重疾型)"
    echo -e "     - 精算优势：利用 50% 的首10年赠送保额，对冲高额家庭债务 ($HAS_LOAN) 带来的身故/重疾风险。"
    echo -e "     - 流动性：分红锁定选项允许将收益转为保证账户，确保财务稳健性。"
elif [ $ANNUAL -ge 100000 ]; then
    echo -e "  【方案 B：灵活储备】 友邦环宇盈活计划 (阶梯现金流型)"
    echo -e "     - 精算优势：5年投入，锁定长期复利。解决赡养责任 ($HAS_DEPENDENTS) 所需的确定性现金流。"
else
    echo -e "  【阶段建议】 筑基与防御"
    echo -e "     - 分析：鉴于现有资源，建议先将医疗险位阶提升至 VIP 级别，待余力增加后再补齐长期重疾。"
fi

# --- 第四部分：专业咨询执行建议 ---
echo -e "\n${CYAN}[ 04 / 专家测评结论 ]${NC}"
echo -e "----------------------------------------------------------------"
echo -e "  💡 首席规划师：您的风险缺口在于‘高责任 vs 浅覆盖’。本方案通过【众民保】锁死治疗费支出，"
echo -e "                  再通过【AIA】锁定未来现金流，形成完整的家庭财务护城河。"
echo -e "  📅 此建议书由知识库解析生成，具备 30 天有效期，建议在窗口期内完成投保观察。"

echo -e "\n${BLUE}================================================================${NC}"
echo -e "           声明：本建议书引用《2026培训细则》，最终以实际合同为准。"
echo -e "${BLUE}================================================================${NC}"
