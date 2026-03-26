# Insurance_skill 🛡️

这是一个动态的保险知识库与咨询建议系统。

## 🌟 核心功能

1.  **动态知识挂载 (Plug-and-Play)**：
    *   您可以将任何保险相关的 PDF 文件放入 [plugins/](./plugins/) 文件夹。
    *   通过运行 `./Insurance_skill sync` 命令，大模型会自动解析这些 PDF 并将其转化为结构化的 Markdown 知识库。
2.  **智能保险推荐**：
    *   系统会根据您上传的知识库内容，自动匹配最适合用户的保险类型与方案。
    *   基于用户的健康状况、职业和收入进行深度风险评估。
3.  **专业且靠谱的咨询口吻**：
    *   输出逻辑经过精心调优，以“关心、专业、透明”的口吻提供建议，拒绝推销感。

## 🚀 快速开始

### 1. 准备知识库
将您的保险 PDF 文档放入 `plugins/` 目录。

### 2. 同步数据
```bash
./Insurance_skill sync
```

### 3. 进行健康分析
```bash
./Insurance_skill assess 30 男 互联网大厂 33000 无病史
```

### 4. 获取详细建议
根据 `assess` 命令返回的画像数据，运行：
```bash
./Insurance_skill recommend "<画像数据>"
```

## 📂 项目结构
- `plugins/`: 原始 PDF 存放处。
- `knowledge/`: 自动生成的 Markdown 知识库。
- `scripts/`: 核心解析与推荐逻辑脚本。
- `Insurance_skill`: 统一命令行入口。

---
*本项目旨在通过 AI 技术实现保险知识的结构化与平民化。*
