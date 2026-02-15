# Git 규칙

## 커밋
- 커밋 메시지는 한국어로 작성
- 하나의 커밋 = 하나의 논리적 변경
- 커밋 전 반드시 diff 확인

## 브랜치
- main/master에 직접 커밋 금지
- 브랜치명: feature/기능명, fix/버그명, refactor/대상
- 작업 완료 후 PR을 통해 머지

## 금지 사항
- .env, 시크릿, API 키 절대 커밋하지 않기
- node_modules/, __pycache__/, .venv/ 커밋 금지
- 대용량 바이너리 파일 커밋 금지
