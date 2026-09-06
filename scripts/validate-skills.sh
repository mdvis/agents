#!/usr/bin/env bash
# 校验 skills/ 下所有技能是否符合 Agent Skills 标准
# 标准: https://agentskills.io — SKILL.md 必须包含 YAML frontmatter,
# 且至少有 name / description 两个字段, name 需与目录名一致

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$ROOT/skills"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

errors=0
count=0

if [ ! -d "$SKILLS_DIR" ]; then
  echo "error: $SKILLS_DIR not found"
  exit 1
fi

for dir in "$SKILLS_DIR"/*/; do
  [ -d "$dir" ] || continue
  count=$((count + 1))
  dirname="$(basename "$dir")"
  skill_md="$dir/SKILL.md"

  if [ ! -f "$skill_md" ]; then
    echo -e "${RED}[FAIL]${NC} $dirname: missing SKILL.md"
    errors=$((errors + 1))
    continue
  fi

  # 提取 frontmatter（第一个 --- 到第二个 --- 之间）
  frontmatter="$(awk 'NR==1 && /^---[[:space:]]*$/{fm=1;next} fm && /^---[[:space:]]*$/{exit} fm' "$skill_md")"

  if [ -z "$frontmatter" ]; then
    echo -e "${RED}[FAIL]${NC} $dirname: no YAML frontmatter"
    errors=$((errors + 1))
    continue
  fi

  name="$(printf '%s\n' "$frontmatter" | sed -n 's/^name:[[:space:]]*//p' | tr -d '"' | head -1)"
  description="$(printf '%s\n' "$frontmatter" | sed -n 's/^description:[[:space:]]*//p' | head -1)"

  if [ -z "$name" ]; then
    echo -e "${RED}[FAIL]${NC} $dirname: frontmatter missing 'name'"
    errors=$((errors + 1))
  elif [ "$name" != "$dirname" ]; then
    echo -e "${RED}[FAIL]${NC} $dirname: name '$name' does not match directory name"
    errors=$((errors + 1))
  fi

  if [ -z "$description" ]; then
    echo -e "${RED}[FAIL]${NC} $dirname: frontmatter missing 'description'"
    errors=$((errors + 1))
  fi

  if [ "$name" = "$dirname" ] && [ -n "$description" ]; then
    echo -e "${GREEN}[ OK ]${NC} $dirname"
  fi
done

if [ "$count" -eq 0 ]; then
  echo "error: no skills found in $SKILLS_DIR"
  exit 1
fi

echo
if [ "$errors" -gt 0 ]; then
  echo -e "${RED}Validation failed: $errors error(s) in $count skill(s)${NC}"
  exit 1
fi
echo -e "${GREEN}All $count skill(s) valid${NC}"
