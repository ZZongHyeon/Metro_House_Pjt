## 📦 개발 환경 구성

| 항목 | 상세 내용 |
|------|------|
| **개발 언어** | Java (JDK 8+), JavaScript |
| **프레임워크** | Spring Boot, Spring MVC, MyBatis |
| **데이터베이스** | Oracle 11g 이상 |
| **빌드 도구** | Gradle |
| **WAS** | Spring Boot Embedded Tomcat |
| **형상관리** | Git, GitHub |
| **협업 도구** | Jira, Notion |
| **API 테스트** | Postman |

## 🛠️ 기술 스택 (Tech Stack)

### 🌐 Frontend

| 기술 | 설명 |
|------|------|
| **JSP** | 서버 사이드 렌더링 기반 동적 HTML 생성 |
| **JavaScript / jQuery** | 클라이언트 상호작용 구현 및 Ajax 요청 처리 |
| **Bootstrap** | 반응형 UI 디자인 구현 |
| **MyBatis** | View와 DB 간의 데이터 매핑 처리 (JSP ↔ DAO) |

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

## 🔌 외부 연동 API

- **Naver SMTP** – 이메일 인증 시스템 구현  
- **Kakao 주소 API** – 회원가입 주소 자동입력  
- **OAuth2 (Naver, Kakao, Google)** – 소셜 로그인 연동 
- **공공데이터포털 Open API** – 전국 아파트 실거래가 정보 주기적 수집  
- **Kakao Map API** – 위도/경도 기반 아파트 위치 시각화 및 반경 기반 검색  

## 💻 개발 도구

| 도구 | 목적 |
|------|------|
| **IntelliJ IDEA / Eclipse** | Java 백엔드 및 Spring Boot 개발 |
| **Visual Studio Code** | 프론트엔드, JSP 및 JS 개발 |
| **Postman** | API 테스트 및 디버깅 |
| **GitHub** | 프로젝트 버전 관리 및 협업 |
| **Notion** | 기획/기록/문서화 |
| **Jira** | 업무 프로세스 관리, 일정 계획 |

## ✅ 핵심 기술 요약

- JWT + OAuth2 **기반 로그인/인증 시스템**
- Spring Security **기반 권한 분기 및 접근 제어 구현**
- Oracle + MyBatis **활용한 데이터 핸들링**
- 공공데이터 Open API를 활용한 **실거래가 자동 수집기**
- Kakao Map 기반 **아파트 위치 시각화 및 필터링**

## 📊 데이터베이스 
<a name="trade-section-top-erd"></a>
<details>
<summary>ERD</summary>
  <br>
<ul>
  <li><b>사용자 관리</b>
    <ul>
      <li>USERINFO: 사용자 기본 정보</li>
      <li>USER_SESSIONS: 유저 세션 관리</li>
    </ul>
  </li>
<br>
  <li><b>도서 관리</b>
    <ul>
      <li>BOOKINFO: 도서 정보</li>
      <li>BOOK_BORROW / BOOK_RECORD: 도서 대출 및 반납 기록</li>
      <li>BOOK_REVIEW / BOOK_WISHLIST: 도서 리뷰 및 관심 도서 목록</li>
    </ul>
  </li>
<br>
  <li><b>커뮤니티 기능</b>
    <ul>
      <li>BOARD: 게시판</li>
      <li>BOARD_COMMENT: 댓글</li>
      <li>BOARD_LIKES: 게시글 추천</li>
    </ul>
  </li>
<br>
  <li><b>공지사항</b>
    <ul>
      <li>NOTICE: 운영자 공지사항 관리</li>
    </ul>
  </li>
<br>
  <li><b>중고 도서 거래</b>
    <ul>
      <li>TRADE_POST: 중고 도서 게시글</li>
      <li>TRADE_FAVORITE: 관심 등록 기능</li>
      <li>TRADE_RECORD: 거래 완료 기록</li>
    </ul>
  </li>
<br>
  <li><b>실시간 채팅</b>
    <ul>
      <li>TRADE_CHATROOM: 채팅방</li>
      <li>TRADE_CHATMESSAGE: 채팅 메시지</li>
    </ul>
  </li>
<br>
  <li><b>사용자 알림</b>
    <ul>
      <li>NOTIFICATIONS: 이벤트 및 메시지 알림 시스템</li>
    </ul>
  </li>
</ul>
<br>
  
## 📌 ERD
![MetroHouse](https://github.com/pingpingeee/Metro_House_Pjt/blob/main/lib/images/erd/ERD.png?raw=true)

### 🔝 [이 섹션 맨 위로 이동](#trade-section-top-erd)
</details>
