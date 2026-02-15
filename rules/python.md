# Python 규칙

## 스타일
- Python 3.10+ 문법 사용
- f-string 사용 (format(), % 포맷팅 금지)
- 타입 힌트 필수 (함수 인자, 반환값)
- snake_case 사용 (클래스만 PascalCase)

## 구조
- 함수는 하나의 역할만 수행 (20줄 이내 권장)
- import는 표준 라이브러리 / 서드파티 / 로컬 순서로 그룹핑
- 순환 import 금지
- `*` import 금지 (from module import * 사용하지 않기)

## 에러 처리
- bare except 금지 (`except:` 대신 `except Exception:`)
- 구체적인 예외 타입으로 catch
- 에러 메시지에 컨텍스트 포함

## 테스트
- pytest 사용
- 테스트 함수명은 test_무엇을_어떤상황에서_어떻게 형식
- fixture 활용, 테스트 간 상태 공유 금지

## 보안
- 환경변수로 시크릿 관리 (.env + python-dotenv)
- SQL은 ORM 또는 파라미터 바인딩 사용 (raw query에 f-string 금지)
- 사용자 입력은 항상 검증
