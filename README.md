# Agents Configuration Manager

统一管理 AI Agent 的配置与技能模块。

## 📁 项目结构

```
agents/
├── agents/          # Agent 配置文件
├── hooks/           # Git hooks（自动提交脚本）
├── skills/          # Agent 技能模块
│   ├── generate-operation-manual/  # 操作手册生成
│   ├── git-commit-helper/          # Git 提交辅助
│   ├── merge-documents/            # 文档合并
│   ├── scaffold-pages/             # 页面脚手架
│   ├── split-documents/            # 文档拆分
│   ├── verify-documents/           # 文档校验
│   └── unit-test-writer/           # 单元测试生成
├── link-agents.sh  # 软链接工具脚本
└── README.md       # 本文件
```

## 🚀 快速开始

### 安装

将配置软链接到各个 AI 工具：

```bash
bash link-agents.sh
```

该脚本会自动在 `$HOME` 下创建对应的符号链接：

| 工具       | 路径              |
|------------|-------------------|
| Claude     | `~/.claude`       |
| Pi         | `~/.pi/agent`     |
| Codex      | `~/.codex`        |
| Workbuddy  | `~/.workbuddy`    |
| OpenCode   | `~/.opencode`     |
| CodeBuddy  | `~/.codebuddy`    |
| Hermes     | `~/.hermes`       |

## 🛠 Skills（技能模块）

每个 skill 都包含 `SKILL.md` 定义文件，可直接被 Agent 读取使用：

- **generate-operation-manual** — 自动生成操作手册
- **git-commit-helper** — Git commit message 辅助生成
- **merge-documents** — 多文档合并整理
- **scaffold-pages** — 快速搭建页面结构
- **split-documents** — 长文档智能拆分
- **verify-documents** — 文档质量校验
- **unit-test-writer** — 单元测试自动生成

## 📌 Hooks

项目内置了 Git hooks，位于 `hooks/` 目录下：

- `auto-commit.sh` — 自动提交脚本

## ⚙️ 环境要求

- Bash 4.0+
- macOS / Linux（支持符号链接）

## 📄 License

MIT
