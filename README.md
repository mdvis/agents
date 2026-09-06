# Agents Configuration Manager

统一管理 AI Agent 的配置与技能模块。

## 📁 项目结构

```
agents/
├── agents/          # Agent 配置文件
├── hooks/           # Git hooks（自动提交脚本）
├── skills/          # Agent 技能模块（标准 Agent Skills 格式）
│   ├── generate-operation-manual/  # 操作手册生成
│   ├── git-commit-helper/          # Git 提交辅助
│   ├── merge-documents/            # 文档合并
│   ├── scaffold-pages/             # 页面脚手架
│   ├── split-documents/            # 文档拆分
│   └── verify-documents/           # 文档校验
├── scripts/         # 维护脚本（技能校验等）
└── README.md       # 本文件
```

> `unit-test-writer` 为单文件 Agent 配置，位于 `agents/unit-test-writer.md`。

## 🚀 快速开始

本仓库技能遵循 [Agent Skills](https://agentskills.io) 标准（`SKILL.md` + `name`/`description` frontmatter），可被 [skills CLI](https://skills.sh) 直接安装到 Claude Code、Codex、Cursor、OpenCode 等 75+ 工具：

```bash
# 交互式安装（选择技能与目标工具）
npx skills add mdvis/agents

# 全局安装到用户目录（~/.skills，跨项目可用）
npx skills add mdvis/agents -g

# 安装指定技能
npx skills add mdvis/agents --skill git-commit-helper --skill merge-documents

# 安装全部技能到全部工具（无交互）
npx skills add mdvis/agents --all

# 查看仓库内可用技能
npx skills add mdvis/agents --list
```

安装后可用 `npx skills list` 查看、`npx skills update` 更新。

## 🛠 Skills（技能模块）

每个 skill 都包含标准 `SKILL.md` 定义文件，可直接被 Agent 读取使用：

| 技能 | 版本 | 说明 |
|------|------|------|
| generate-operation-manual | 1.0.0 | 生成 Web 应用中文图文操作手册（Playwright 截图） |
| git-commit-helper | 1.0.0 | 按 Conventional Commits 规范生成提交信息 |
| merge-documents | 1.0.1 | 多文档合并整理 |
| scaffold-pages | 1.0.0 | 页面级新功能脚手架 |
| split-documents | 1.0.1 | 长文档智能拆分 |
| verify-documents | 1.0.0 | 文档完整性与一致性校验 |

## ➕ 新增 / 维护技能

1. 在 `skills/<skill-name>/` 下创建 `SKILL.md`，frontmatter 必须包含：
   - `name`：与目录名一致（小写字母 + 连字符）
   - `description`：一句话说明功能（触发词可写入 `triggers` 字段）
   - 可选：`version`、`triggers`、`tags`、`dependencies`
2. 运行 `bash scripts/validate-skills.sh` 校验格式
3. 提交推送后，CI 会自动再次校验

## ✅ 校验与 CI

```bash
bash scripts/validate-skills.sh
```

GitHub Actions（`.github/workflows/validate.yml`）在 `skills/**` 变更时自动运行同样校验，防止不合规技能合入。

## 📌 Hooks

项目内置了 Git hooks，位于 `hooks/` 目录下：

- `auto-commit.sh` — 自动提交脚本

## ⚙️ 环境要求

- Node.js 18+（`npx skills` 安装方式）
- macOS / Linux

## 📄 License

MIT
