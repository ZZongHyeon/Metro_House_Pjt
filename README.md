## 📦 개발 환경 요약

| 항목 | 내용 |
|------|------|
| **개발 언어** | Java (JDK 8+), JavaScript |
| **프레임워크** | Spring Boot, Spring MVC, MyBatis |
| **데이터베이스** | Oracle 11g 이상 |
| **빌드 도구** | Gradle |
| **WAS** | Spring Boot Embedded Tomcat |
| **형상관리** | Git, GitHub |
| **협업 도구** | Jira, Notion |
| **API 테스트** | Postman |

---

## 🛠️ 기술 스택 (Tech Stack)

### 🌐 Frontend

| 기술 | 설명 |
|------|------|
| **JSP** | 서버 사이드 렌더링 기반 동적 HTML 처리 |
| **JavaScript / jQuery** | DOM 조작, AJAX 통신 기반 사용자 상호작용 구현 |
| **CSS3 / Bootstrap** | 반응형 디자인 및 컴포넌트 기반 UI 구성 |
| **Font Awesome** | 직관적인 UI 아이콘 구성 (좋아요, 조회수 등 시각화) |

---

### ⚙ Backend

| 기술 | 설명 |
|------|------|
| **Spring Boot** | RESTful API 구현, 설정 자동화, 내장 톰캣 기반 서버 환경 |
| **Spring MVC** | 계층화된 컨트롤러-서비스 구조로 웹 애플리케이션 구현 |
| **MyBatis** | SQL 중심 ORM, DB 연동 및 동적 쿼리 처리 |
| **Oracle** | 게시글/댓글/좋아요/거래 데이터 관리용 RDBMS |
| **Spring Security** | 사용자 인증/인가 및 세션 관리 구현 |
| **JWT** | 토큰 기반 인증 구조, 무상태 인증 처리 방식 적용 |
| **공공데이터포털 API** | 실거래가 데이터 수집 및 OracleDB 저장 자동화 |
| **Kakao Map API** | 아파트 위치 시각화 및 지도 기반 필터링 지원 |

---

## 🔌 외부 연동 API

- **공공데이터포털 Open API** – 전국 아파트 실거래가 정보 주기적 수집  
- **Kakao Map API** – 위도/경도 기반 아파트 위치 시각화 및 반경 기반 검색  

---

## 💻 개발 도구

| 도구 | 목적 |
|------|------|
| **IntelliJ IDEA / STS** | Java 및 Spring Boot 개발 환경 |
| **VS Code** | JSP, JavaScript, CSS 등 프론트엔드 리소스 작성 |
| **Postman** | REST API 테스트 및 디버깅 |
| **GitHub** | 소스코드 버전 관리 및 협업 |
| **Jira** | 태스크 관리 및 애자일 기반 일정 운영 |
| **Notion** | 문서화 및 기획서 공유 |

---

## ✅ 핵심 기술 요약

- JWT 기반 **무상태 인증 시스템**
- 공공데이터 Open API를 활용한 **실거래가 자동 수집기**
- Kakao Map 기반 **아파트 위치 시각화 및 필터링**
- 좋아요 기능 및 **조회수 기반 정렬 게시판**
- Spring Security 기반 **접근 제어 및 권한 분리**

---


### ERD
![스크린샷 2025-07-02 113603](https://github.com/user-attachments/assets/21c4456a-779b-4199-a394-c82380a5dd1c)


# 로그인
![로그인화면](https://github.com/user-attachments/assets/2e5c1feb-a582-4577-82ee-286c45ddd362)
---

# 회원가입
![회원가입](https://github.com/user-attachments/assets/549e6f81-6cb7-4683-bf9a-24332af3d177)
---

# 메인화면(JWT토큰)
![메인1](https://github.com/user-attachments/assets/95f646a8-ddc6-4814-83a4-4144fa13db0f)
![메인2](https://github.com/user-attachments/assets/1c4d5b63-69d2-41cf-91a0-59948a7b85dc)
---

# 게시판
![게시판](https://github.com/user-attachments/assets/86f3ff7a-bf50-4e10-bf69-f2ff199e26ce)
![게시글1](https://github.com/user-attachments/assets/39fc1e1d-3e15-49c0-8138-9862b705f803)
![게시글2(댓글)_](https://github.com/user-attachments/assets/f89461f5-2704-4a98-b5e2-d8b133a02126)
---

# 지도(지하철역 인근 아파트 검색 & 비교)
![지도메인1](https://github.com/user-attachments/assets/3e54061f-bc92-45e5-9c9e-05635e4064f7)
![지도메인2값비교](https://github.com/user-attachments/assets/30915245-08c5-44d3-8d90-25c0b72fbff7)
---

# 아파트 상세
![아파트상세](https://github.com/user-attachments/assets/32144030-d4be-4c22-aeae-0da3d836fcca)
![아파트상세2](https://github.com/user-attachments/assets/1e084275-e412-47bf-ac7e-06b8d714392d)
---

# 마이페이지 & 관리자전용 아파트 데이터 최신화
![마이페이지](https://github.com/user-attachments/assets/8480066f-e6c2-49cd-b8c1-90a57c339af6)
![관리자전용 데이터 최신화](https://github.com/user-attachments/assets/93a47705-bc17-4d39-93f9-3b555efdff09)
---
