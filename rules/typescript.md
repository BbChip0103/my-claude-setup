# TypeScript 규칙

## 타입
- any 사용 금지, unknown 또는 구체적 타입 사용
- interface 우선 사용 (type은 유니온/인터섹션에만)
- as 타입 단언 최소화, 타입 가드 함수 활용
- enum 대신 as const 객체 사용 권장

## 스타일
- camelCase (변수, 함수), PascalCase (컴포넌트, 타입, 인터페이스)
- 화살표 함수 사용 (단, React 컴포넌트는 function 선언도 허용)
- optional chaining (?.) 과 nullish coalescing (??) 활용
- 삼항 연산자는 한 줄일 때만 사용

## React/Next.js
- 컴포넌트는 하나의 파일에 하나만
- props는 interface로 정의
- useState 남용 금지, 파생 가능한 값은 계산으로 처리
- useEffect 의존성 배열 정확히 명시
- 서버 컴포넌트 우선, 클라이언트 컴포넌트는 필요할 때만 'use client'

## 에러 처리
- try-catch에서 에러 타입 확인 (instanceof)
- API 호출은 반드시 에러 처리
- 사용자에게 보여주는 에러 메시지는 친절하게

## 보안
- dangerouslySetInnerHTML 사용 금지
- 환경변수는 NEXT_PUBLIC_ 접두사 구분 철저히
- 사용자 입력은 서버에서 반드시 검증 (zod 권장)
