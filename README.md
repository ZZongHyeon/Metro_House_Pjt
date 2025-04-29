# Metro_House_Pjt

  <img src="https://img.shields.io/badge/java-007396?style=for-the-badge&logo=java&logoColor=white"> 
  <img src="https://img.shields.io/badge/oracle-F80000?style=for-the-badge&logo=oracle&logoColor=white"> 
  <img src="https://img.shields.io/badge/spring-6DB33F?style=for-the-badge&logo=spring&logoColor=white"> 

## 📦 개발 환경 구조 요약

| 구분 | 내용
|-----|-----
| 개발 언어 | Java (JDK 17), JavaScript
| 프레임워크 | Spring Boot 2.7.13
| DB | Oracle 11g 이상
| 빌드 도구 | Maven/Gradle
| 형상관리 | Git / GitHub
| 협업 도구 | Jira, Notion


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
| Spring Security | 사용자 인증 및 권한 관리 (선택적)


### 🛠️ 개발 도구 (Development Tools)

| 도구 | 사용 목적
|-----|-----
| Visual Studio Code | JS, CSS, 프론트 등 코드 작성용 에디터
| IntelliJ IDEA/STS | Spring Boot 기반 프로젝트 개발 환경
| Jira | 이슈 관리 및 구체적인 일정 계획 수립을 위한 협업 도구
| GitHub | 코드 버전 관리 및 팀 협업
| Postman | API 테스트


<details><summary><b>📝 패치 (2025-04-27)</b></summary>

<pre><b>게시판 기능:</b>
• 게시글 페이징 구현
• 검색 결과 페이징 기능 추가

<b>댓글 시스템:</b>
• 댓글 페이징 구현 (기본댓글 10개 기준)
• 대댓글은 페이징에서 제외하여 사용성 개선

<b>추천 시스템:</b>
• 추천 취소 기능 추가
• 추천 상태에 따른 버튼 색상 반전 효과 적용

</pre></details>

<details><summary><b>📝 패치 (2025-04-28)</b></summary>

<pre><b>카카오맵api:</b>
• 카카오맵 api이용하여 지도 표현

<b>검색 & 지도:</b>
• 시, 구/군, 지하철역 검색 시 해당 지하철역 포커싱되고 마커등록
• 주변 아파트 마커등록, 데이터표현(현재 임시데이터)
  
</pre></details>

<details><summary><b>📝 패치 (2025-04-29)</b></summary>

<pre><b>Spring Security:</b>
• 서버쪽 보안 강화
• 비로그인시 필요한 로그인&회원가입&이메일인증, 필요한 뷰들 제외
• 비밀번호 암호화&복호화

<b>이메일 인증:</b>
• 네이버 SMTP서버이용하여 이메일전송
• 서버에 저장하여 검증

</pre></details>


<details><summary><b>application.properties</b></summary>

<pre>spring.application.name=Metro_House_Pjt
server.port=8485

#Spring MVC
spring.mvc.view.prefix=/WEB-INF/views/
spring.mvc.view.suffix=.jsp

#Database config
spring.datasource.driver-class-name=oracle.jdbc.OracleDriver
spring.datasource.url=jdbc:oracle:thin:@localhost:1521:xe
spring.datasource.username=metro_house
spring.datasource.password=1234

#mybatis config
mybatis.config-location=classpath:mybatis-config.xml

#kakao.api.key=${KAKAO_API_KEY}
kakao.api.key=카카오 api 등록해주세요.

#naver email
smtp_id=네이버 아이디 등록해주세요.
smtp_pw=네이버 비밀번호 등록해주세요.


</pre></details>



<details>
  <summary>게시글 더미값 삽입</summary>
  <pre><code>
BEGIN
  FOR i IN 1..300 LOOP
    INSERT INTO board (boardNumber, userName, boardTitle, boardContent, boardWriteDate, boardViews)
    VALUES (i, '사용자'||i, '제목'||i, '내용'||i, SYSDATE, 0);
    
    IF MOD(i, 100) = 0 THEN
      COMMIT;
    END IF;
  END LOOP;
  COMMIT;
END;
  </code></pre>
</details>


<details>
  <summary>쿼리(2025-04-27)</summary>
  <pre><code>
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE, 
      CREATE SYNONYM, CREATE PROCEDURE, CREATE TRIGGER, CREATE MATERIALIZED VIEW 
TO METRO_HOUSE;
GRANT SELECT ANY TABLE, INSERT ANY TABLE, UPDATE ANY TABLE, DELETE ANY TABLE
TO METRO_HOUSE;
ALTER USER METRO_HOUSE DEFAULT TABLESPACE USERS;
ALTER USER METRO_HOUSE QUOTA UNLIMITED ON USERS;


CREATE TABLE USERINFO (
userNumber      NUMBER PRIMARY KEY,
userId          VARCHAR2(100),
userPw          VARCHAR2(100),
userName        VARCHAR2(100),
userTel         VARCHAR2(20),
userEmail       VARCHAR2(200),
userBirth       VARCHAR2(50),
userZipCode     VARCHAR2(50),
userAddress     VARCHAR2(300),
userDetailAddress VARCHAR2(500),
userAdmin       NUMBER DEFAULT 0,
userRegdate     DATE DEFAULT SYSDATE
);


CREATE TABLE BOARD (
boardNumber     NUMBER PRIMARY KEY,
userNumber      NUMBER,
userName        VARCHAR2(50),
boardTitle      VARCHAR2(1000),
boardContent    VARCHAR2(4000),
boardWriteDate  DATE DEFAULT SYSDATE,
boardHit        NUMBER DEFAULT 0,
boardViews      NUMBER DEFAULT 0,
boardLikes      NUMBER DEFAULT 0,
FOREIGN KEY (userNumber) REFERENCES USERINFO(userNumber)ON DELETE CASCADE
);


CREATE TABLE board_likes (
boardNumber number,
userNumber number,
PRIMARY KEY (boardNumber, userNumber)
);


CREATE TABLE BOARD_COMMENT (
commentNumber       NUMBER PRIMARY KEY,
commentSubNumber    NUMBER,
commentSubStepNumber NUMBER,
boardNumber         NUMBER,
userNumber          NUMBER,
userName            VARCHAR2(50),
commentContent      VARCHAR2(4000),
commentWriteDate    DATE DEFAULT SYSDATE
);


ALTER TABLE BOARD_COMMENT
ADD CONSTRAINT fk_comment_board
FOREIGN KEY (boardNumber)
REFERENCES BOARD(boardNumber)
ON DELETE CASCADE;


ALTER TABLE BOARD_COMMENT
ADD CONSTRAINT fk_comment_user
FOREIGN KEY (userNumber)
REFERENCES USERINFO(userNumber)
ON DELETE CASCADE;
DESC board_comment;
  </code></pre>
</details>
