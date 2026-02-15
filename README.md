# my-claude-setup

Claude Code 환경 세팅 모음. 규칙, 커맨드, 플러그인, 스킬을 한 번에 설치합니다.

## 사전 준비

```bash
# 1. Node.js (fnm으로 설치)
curl -fsSL https://fnm.vercel.app/install | bash
source ~/.bashrc
fnm install --lts

# 2. gh CLI
curl -sL "https://github.com/cli/cli/releases/latest/download/gh_$(gh_ver)_linux_amd64.tar.gz" -o /tmp/gh.tar.gz
# 또는 https://cli.github.com/ 에서 OS에 맞게 설치
gh auth login
```

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
├── install.sh              # 원클릭 설치 스크립트
├── rules/                  # ~/.claude/rules/ 에 복사되는 규칙들
│   ├── default.md          # 기본 코딩 규칙
│   ├── python.md           # Python 전용 규칙
│   ├── typescript.md       # TypeScript/React/Next.js 규칙
│   ├── git.md              # Git 워크플로우 규칙
│   └── junior-guide.md     # 주니어 개발자 가이드
├── commands/               # ~/.claude/commands/ 에 복사되는 커맨드들
│   ├── review.md           # /review  코드 리뷰
│   ├── plan.md             # /plan    구현 계획 수립
│   ├── test.md             # /test    테스트 실행 및 분석
│   ├── explain.md          # /explain 코드 설명 (주니어 눈높이)
│   ├── debug.md            # /debug   에러 분석 및 해결
│   └── refactor.md         # /refactor 리팩토링
├── settings.json           # Claude Code 설정
└── CLAUDE.md.template      # 프로젝트별 CLAUDE.md 템플릿
```

## 플러그인 (Claude Code CLI에서 수동 설치)

install.sh 실행 후, Claude Code CLI 안에서 아래 명령어를 실행하세요:

```
# superpowers: 계획 → TDD → 구현 → 리뷰 워크플로우
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace

# claude-mem: 세션 간 메모리 유지
/plugin marketplace add thedotmack/claude-mem
/plugin install claude-mem@thedotmack

# oh-my-claudecode (OMC): 멀티 에이전트 오케스트레이션
/plugin marketplace add https://github.com/Yeachan-Heo/oh-my-claudecode.git omc
/plugin install oh-my-claudecode@omc
```

## 스킬 (npx로 설치)

```bash
# Vercel React/Next.js 스킬 (프로젝트 디렉토리에서 실행)
npx -y skills add vercel-labs/agent-skills -y
```

설치되는 스킬:
- vercel-composition-patterns (컴포넌트 합성 패턴)
- vercel-react-best-practices (React 모범 사례)
- vercel-react-native-skills (React Native)
- web-design-guidelines (웹 디자인 가이드라인)

## 설치 후

1. `~/.claude/rules/` 에 규칙이 적용됩니다 (모든 프로젝트 공통)
2. `~/.claude/commands/` 에 슬래시 커맨드가 추가됩니다
3. 플러그인은 Claude Code 재시작 후 적용됩니다
4. 프로젝트별로 `CLAUDE.md`가 필요하면 템플릿을 복사하세요:

```bash
cp CLAUDE.md.template /path/to/your/project/CLAUDE.md
```

## 토큰 절약 필수 설정

### 1. 기본 모델을 Sonnet으로 고정

`settings.json`에서 기본 모델을 Sonnet으로 설정하면 실수로 Opus를 사용하는 것을 방지합니다.
복잡한 작업이 필요할 때만 `/model opus` 로 전환하세요.

```json
{
  "model": "claude-sonnet-4-5-20250929"
}
```

### 2. /clear + /compact 로 컨텍스트 관리

- `/compact` — 대화 내용을 요약해서 컨텍스트 윈도우를 확보
- `/clear` — 대화를 완전히 초기화 (새 작업 시작 시)
- 작업 전환 시 `/clear` → 새 작업 시작이 가장 토큰 효율적

### 3. 계획은 Opus, 코딩은 Sonnet 자동 전환

OMC(oh-my-claudecode)가 자동으로 처리합니다:
- 아키텍처/분석/계획 → Opus
- 구현/디버깅/리뷰 → Sonnet
- 간단한 탐색/조회 → Haiku

수동 전환: `/model opus` (계획 시) → `/model sonnet` (코딩 시)

### 4. 구체적인 프롬프트 작성

```
# 나쁜 예 (파일 탐색에 토큰 낭비)
"로그인 기능 고쳐줘"

# 좋은 예 (정확한 위치 지정)
"src/auth/login.ts의 validateToken 함수에서 만료 체크 로직 수정해줘"
```

- 파일 경로, 함수명, 라인 번호를 포함하면 탐색 토큰 절약
- 한 번에 하나의 작업만 요청 → 컨텍스트 오염 방지

### 5. CLAUDE.md 500줄 이하 유지

CLAUDE.md는 매 세션마다 로드됩니다. 길수록 기본 토큰이 늘어납니다.

- 프로젝트 CLAUDE.md: 500줄 이하 권장
- 핵심 규칙만 남기고, 상세 내용은 별도 파일로 분리
- `rules/` 폴더 활용 → 필요한 규칙만 선택 적용

## 커스터마이즈

- `rules/` 에 `.md` 파일을 추가하면 규칙 추가
- `commands/` 에 `.md` 파일을 추가하면 슬래시 커맨드 추가
- 파일명이 곧 커맨드 이름 (예: `review.md` → `/review`)
