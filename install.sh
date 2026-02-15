#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Claude Code 환경 세팅 시작 ==="

# 1. rules 설치
echo ""
echo "[1/3] 규칙(rules) 설치 중..."
mkdir -p ~/.claude/rules
cp "$SCRIPT_DIR"/rules/*.md ~/.claude/rules/
echo "  -> ~/.claude/rules/ 에 복사 완료"
ls ~/.claude/rules/

# 2. commands 설치
echo ""
echo "[2/3] 커맨드(commands) 설치 중..."
mkdir -p ~/.claude/commands
cp "$SCRIPT_DIR"/commands/*.md ~/.claude/commands/
echo "  -> ~/.claude/commands/ 에 복사 완료"
ls ~/.claude/commands/

# 3. settings 설치
echo ""
echo "[3/3] 설정(settings) 설치 중..."
if [ -f ~/.claude/settings.json ] && [ "$(cat ~/.claude/settings.json)" != "{}" ]; then
    echo "  -> 기존 settings.json이 있습니다. 덮어쓰지 않습니다."
    echo "  -> 수동으로 병합하려면: $SCRIPT_DIR/settings.json 를 참고하세요"
else
    cp "$SCRIPT_DIR"/settings.json ~/.claude/settings.json
    echo "  -> ~/.claude/settings.json 복사 완료"
fi

echo ""
echo "=== 설치 완료! ==="
echo ""
echo "적용된 규칙:"
for f in ~/.claude/rules/*.md; do
    echo "  - $(basename "$f")"
done
echo ""
echo "사용 가능한 커맨드:"
for f in ~/.claude/commands/*.md; do
    name=$(basename "$f" .md)
    echo "  - /$name"
done
echo ""
echo "프로젝트별 CLAUDE.md가 필요하면:"
echo "  cp $SCRIPT_DIR/CLAUDE.md.template /path/to/project/CLAUDE.md"
