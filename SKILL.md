---
version: "3.0.0"
name: insurance-advisor
description: "保险方案顾问（PDF知识库版）。支持健康状况分析、严重既往症检查、中高端医疗险及美元储蓄险推荐。Insurance advisor with health assessment and product recommendation based on latest product PDFs."
author: BytesAgain
homepage: https://bytesagain.com
---
# insurance-advisor
基于 PDF 知识库的专业保险顾问。

## 核心能力
1. **健康状况分析**：基于《众民保2026》健康告知规则，判断用户可投性。
2. **知识库支撑**：
   - **众民保·中高端医疗险 2026**：高龄、带病、高危职业友好。
   - **AIA 爱伴航/环宇盈活**：美元长期/中期储蓄计划。
3. **精准评估**：通过 `assess` 采集信息，`recommend` 生成闭环方案。

## 命令速查

```bash
# 0. 同步外挂知识库 (如有新 PDF 放入 plugins/)
insurance-advisor sync

# 1. 进行健康与财务分析
# 参数: <年龄> <性别> <职业> <月收入> [既往病史...]
insurance-advisor assess 35 男 程序猿 25000 脂肪肝

# 2. 获取针对性产品推荐 (通常紧随 assess 后使用)
insurance-advisor recommend "<assess输出的画像数据>"
```

## 推荐工作流 (AI 自动执行)
1. 询问用户年龄、职业、收入及身体状况。
2. 调用 `bash scripts/assess.sh` 分析风险。
3. 调用 `bash scripts/recommend.sh` 匹配 PDF 知识库中的产品。
4. 解答关于《众民保》或《AIA储蓄险》的细节问题。

---
💬 Powered by BytesAgain | 知识库源自 7 份最新保险产品 PDF
