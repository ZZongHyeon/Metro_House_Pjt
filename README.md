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
| Spring Security | 사용자 인증 및 권한 관리 (선택적)


### 🛠️ 개발 도구 (Development Tools)

| 도구 | 사용 목적
|-----|-----
| Visual Studio Code | JS, CSS, 프론트 등 코드 작성용 에디터
| IntelliJ IDEA/STS | Spring Boot 기반 프로젝트 개발 환경
| Jira | 이슈 관리 및 구체적인 일정 계획 수립을 위한 협업 도구
| GitHub | 코드 버전 관리 및 팀 협업
| Postman | API 테스트


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


create table apartmentinfo(
    apartmentId number primary key,
    sggcd VARCHAR2(10),
    umdnm VARCHAR2(100),
    aptnm VARCHAR2(200),
    jibun VARCHAR2(100),
    excluusear VARCHAR2(50),
    dealYear VARCHAR2(4),
    dealMonth VARCHAR2(2),
    dealDay VARCHAR2(2),
    dealAmount VARCHAR2(100),
    floor VARCHAR2(10),
    buildYear VARCHAR2(4),
    cdealType VARCHAR2(50),
    cdealDay VARCHAR2(50),
    dealingGbn VARCHAR2(50),
    estateAgentSggnm VARCHAR2(100),
    rgstDate VARCHAR2(50),
    aptDong VARCHAR2(50),
    slerGbn VARCHAR2(50),
    buyerGbn VARCHAR2(50),
    landLeaseHoldGbn VARCHAR2(50),
    aptSeq VARCHAR2(50),
    bonbun VARCHAR2(50),
    bubun VARCHAR2(50),
    landCd VARCHAR2(50),
    roadNm VARCHAR2(200),
    roadNmBonbun VARCHAR2(50),
    roadNmBubun VARCHAR2(50),
    roadNmCd VARCHAR2(50),
    roadNmSeq VARCHAR2(50),
    roadNmSggcd VARCHAR2(50),
    roadNmBcd VARCHAR2(50),
    umdcd VARCHAR2(50),
    lat NUMBER(12,8),
    lng NUMBER(12,8),
    subwayStation VARCHAR2(100),
    subwayDistance VARCHAR2(50)
);

-- 위도/경도에 복합 인덱스 생성
CREATE INDEX idx_apartmentinfo_latlng ON APARTMENTINFO(lat, lng);


CREATE SEQUENCE seq_apartmentinfo
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
create table apartment_favorite(
    favoriteId number primary key,
    apartmentId number,
    userNumber number,
    createdAt date default sysdate,
    lat NUMBER(12,8),
    lng NUMBER(12,8),
    dealamount varchar2(100),

    FOREIGN KEY (apartmentId) REFERENCES APARTMENTINFO(apartmentId)ON DELETE CASCADE,
    FOREIGN KEY (userNumber) REFERENCES USERINFO(userNumber)ON DELETE CASCADE
);
CREATE SEQUENCE seq_apartment_favorite
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;
  </code></pre>
</details>
