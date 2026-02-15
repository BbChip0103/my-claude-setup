#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Claude Code 환경 세팅 시작 ==="

# 0. Node.js 확인
echo ""
echo "[0/4] Node.js 확인 중..."
if command -v node &>/dev/null; then
    echo "  -> Node.js $(node --version) 확인됨"
else
    echo "  -> Node.js가 없습니다. 설치 중..."
    curl -fsSL https://fnm.vercel.app/install | bash
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env)"
    fnm install --lts
    echo "  -> Node.js $(node --version) 설치 완료"
fi

# 1. rules 설치
echo ""
echo "[1/4] 규칙(rules) 설치 중..."
mkdir -p ~/.claude/rules
cp "$SCRIPT_DIR"/rules/*.md ~/.claude/rules/
echo "  -> ~/.claude/rules/ 에 복사 완료"

# 2. commands 설치
echo ""
echo "[2/4] 커맨드(commands) 설치 중..."
mkdir -p ~/.claude/commands
cp "$SCRIPT_DIR"/commands/*.md ~/.claude/commands/
echo "  -> ~/.claude/commands/ 에 복사 완료"

# 3. settings 설치
echo ""
echo "[3/4] 설정(settings) 설치 중..."
if [ -f ~/.claude/settings.json ] && [ "$(cat ~/.claude/settings.json)" != "{}" ]; then
    echo "  -> 기존 settings.json이 있습니다. 덮어쓰지 않습니다."
    echo "  -> 수동으로 병합하려면: $SCRIPT_DIR/settings.json 를 참고하세요"
else
    cp "$SCRIPT_DIR"/settings.json ~/.claude/settings.json
    echo "  -> ~/.claude/settings.json 복사 완료"
fi

# 4. Vercel 스킬 설치
echo ""
echo "[4/4] Vercel 스킬 설치 중..."
npx -y skills add vercel-labs/agent-skills -y
echo "  -> 스킬 설치 완료"

echo ""
echo "========================================="
echo "=== 자동 설치 완료! ==="
echo "========================================="
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
echo "========================================="
echo "=== 아래는 Claude Code CLI에서 수동 실행 ==="
echo "========================================="
echo ""
echo "# superpowers (계획 → TDD → 구현 → 리뷰 워크플로우)"
echo "/plugin marketplace add obra/superpowers-marketplace"
echo "/plugin install superpowers@superpowers-marketplace"
echo ""
echo "# claude-mem (세션 간 메모리 유지)"
echo "/plugin marketplace add thedotmack/claude-mem"
echo "/plugin install claude-mem@thedotmack"
echo ""
echo "프로젝트별 CLAUDE.md가 필요하면:"
echo "  cp $SCRIPT_DIR/CLAUDE.md.template /path/to/project/CLAUDE.md"
