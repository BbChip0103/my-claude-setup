# my-claude-setup

Claude Code 환경 세팅 모음. 규칙, 커맨드, 설정을 한 번에 설치합니다.

## 설치 방법

```bash
git clone https://github.com/BbChip0103/my-claude-setup.git
cd my-claude-setup
chmod +x install.sh
./install.sh
```

## 구조

```
my-claude-setup/
├── install.sh             # 원클릭 설치 스크립트
├── rules/                 # ~/.claude/rules/ 에 복사되는 규칙들
│   └── default.md         # 기본 코딩 규칙
├── commands/              # ~/.claude/commands/ 에 복사되는 커맨드들
│   └── review.md          # /review 슬래시 커맨드
├── settings.json          # Claude Code 설정
└── CLAUDE.md.template     # 프로젝트별 CLAUDE.md 템플릿
```

## 설치 후

1. `~/.claude/rules/` 에 규칙이 적용됩니다 (모든 프로젝트 공통)
2. `~/.claude/commands/` 에 슬래시 커맨드가 추가됩니다
3. 프로젝트별로 `CLAUDE.md`가 필요하면 `CLAUDE.md.template`을 복사해서 수정하세요

```bash
cp CLAUDE.md.template /path/to/your/project/CLAUDE.md
```

## 커스터마이즈

- `rules/` 에 `.md` 파일을 추가하면 규칙 추가
- `commands/` 에 `.md` 파일을 추가하면 슬래시 커맨드 추가
- 파일명이 곧 커맨드 이름 (예: `review.md` → `/review`)
