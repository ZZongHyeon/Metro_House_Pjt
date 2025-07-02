# Metro_House_Pjt

  <img src="https://img.shields.io/badge/java-007396?style=for-the-badge&logo=java&logoColor=white"> 
  <img src="https://img.shields.io/badge/oracle-F80000?style=for-the-badge&logo=oracle&logoColor=white"> 
  <img src="https://img.shields.io/badge/spring-6DB33F?style=for-the-badge&logo=spring&logoColor=white"> 

## 📦 개발 환경 구조 요약

| 구분 | 내용
|-----|-----
| **개발 언어** | Java (JDK 8 이상), JavaScript
| **프레임워크** | Spring Boot + MyBatis
| **DB** | Oracle 11g 이상
| **빌드 도구** | Gradle
| **내장 WAS** | Spring Boot 내장 Tomcat
| **형상관리** | Git / GitHub
| **협업 도구** | Jira, Notion


## 기술 스택 (Tech Stack)

### 🌐 프론트엔드 (Frontend)

| 기술 | 설명
|-----|-----
| JSP | 서버 측에서 HTML을 생성하는 렌더링 기술<br>동적인 웹 페이지 구현에 사용
| js/jQuery | 클라이언트 측에 필요한 동작처리, 동적 콘텐츠 로딩<br>AJAX를 통한 비동기 통신으로 좋아요 기능 구현
| CSS | 반응형 디자인 구현, 게시판 및 상세 페이지 스타일링 <br>좋아요 버튼 애니메이션 및 상태 표시 효과
| Font Awesome | 아이콘 라이브러리를 활용한 UI 개선<br>좋아요, 조회수 등 아이콘 강화
| Bootstrap | 반응형 UI 컴포넌트 활용


### ⚙️ 백엔드 (Backend)

| 기술 | 설명
|-----|-----
| Spring Boot | 자동 설정과 내장 서버를 통한 빠른 개발 환경 구축<br>Spring MVC 기반 RESTful API 구현
| Spring MVC | 컨트롤러, 서비스 계층의 구현을 위해 사용<br>표준 MVC 패턴 기반으로 구조화
| MyBatis | SQL과 서버 객체간 매핑담당 도구<br>좋아요 기능 구현을 위한 쿼리 매핑
| Oracle | 대규모 데이터 관리를 위한 관계형 데이터베이스 사용<br>게시글, 댓글, 좋아요 정보 저장
| Spring Security | 사용자 인증 및 권한 관리를 위한 보안 프레임워크<br>JWT 기반 인증 필터 커스터마이징 적용
| JWT (JSON Web Token) | 로그인 이후 사용자 인증을 위한 토큰 방식 사용<br>Spring Security와 연동해 무상태 인증 처리
| 공공데이터포털 API	| 부동산 실거래가 정보 수집<br>전국 아파트 거래 데이터 주기적 수집 및 DB 저장
| Kakao Map API	| 지도 기반 아파트 위치 표시 및 지리 기반 기능 제공<br>위도/경도 기반 주변 정보 시각화에 사용


### 🛠️ 개발 도구 (Development Tools)

| 도구 | 사용 목적
|-----|-----
| Visual Studio Code | JS, CSS, 프론트 등 코드 작성용 에디터
| IntelliJ IDEA/STS | Spring Boot 기반 프로젝트 개발 환경
| Jira | 이슈 관리 및 구체적인 일정 계획 수립을 위한 협업 도구
| GitHub | 코드 버전 관리 및 팀 협업
| Postman | API 테스트


### ERD
![스크린샷 2025-07-02 113603](https://github.com/user-attachments/assets/21c4456a-779b-4199-a394-c82380a5dd1c)
