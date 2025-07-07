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
  <li><b>아파트 정보 관리</b>
    <ul>
      <li>APARTMENTINFO: 아파트 기본 정보</li>
      <li>APARTMENTINFO_QUEUE: 아파트 데이터를 저장할 큐</li>
    </ul>
  </li>
  <br>
  <li><b>아파트 사용자 기능</b>
    <ul>
      <li>APARTMENT_FAVORITE: 관심 아파트</li>
      <li>APARTMENT_REVIEW: 아파트 리뷰</li>
      <li>REVIEW_HELPFUL: 리뷰 도움됨</li>
    </ul>
  </li>
  <li><b>z_년도( ex | z_2016 ) 관리자용 데이터 최신화시 수치에 맞게 테이블 생성</b>
    <ul>
      <li>Z_2016: 2016년의 아파트 정보들</li>
        ...
      <li>Z_2025: 2025년의 아파트 정보들</li>
    </ul>
  </li>
  
</ul>

<br>
  
## 📌 ERD
![MetroHouse](https://github.com/pingpingeee/Metro_House_Pjt/blob/main/lib/images/erd/erd.png?raw=true)

### 🔝 [이 섹션 맨 위로 이동](#trade-section-top-erd)
</details>

## 🖥 주요 화면 및 기능 상세

<a name="trade-section-top1"></a>
<details>
<summary>🔐 로그인 & 회원가입</summary>
  
![MetroHouse](https://github.com/pingpingeee/Metro_House_Pjt/blob/main/lib/images/front/1_1로그인.png?raw=true)

1. 일반 로그인
비회원은 회원가입을 통해 로그인을 할 수 있습니다.
로그인시 **JWT토큰**을 발급받고 사용자는 해당 서비스를 이용 할 수 있습니다.
2. 소셜 로그인
네이버, 카카오, 구글 등을 통해 **소셜 로그인**을 진행 할 수 있습니다.
**소셜 로그인** 또한 **JWT토큰**을 발급받고 해당 서비스를 이용 할 수 있습니다.

---

![MetroHouse](https://github.com/pingpingeee/Metro_House_Pjt/blob/main/lib/images/front/1_2회원가입.png?raw=true)


![MetroHouse](https://github.com/pingpingeee/Ink_Tree_Pjt/blob/main/lib/images/front/1_3이메일인증.png?raw=true)

1. 이메일 인증
**네이버 SMTP**를 활용하여 **이메일 인증 시스템**을 구현했습니다.
이메일 중복 여부를 확인한 후 숫자를 포함한 **8자리 무작위 인증번호**를 생성해 해당 이메일로 전송합니다.
인증번호 전송 후 사용자가 이메일을 수정하면 최종 입력된 이메일로 가입되는 현상이 발생하여 인증번호 전송과 동시에 이메일 입력 필드와 전송 버튼을 비활성화하여 **입력값 변경**을 막는 방식으로 수정하였습니다.
2. 정보 입력
모든 input태그는 해당 패턴에 맞도록 예외처리를 하였습니다.
**카카오 API**를 활용하여 사용자가 주소를 입력하면 우편번호와 도로명이 자동으로 삽입되도록 구현하였습니다.


### 🔝 [이 섹션 맨 위로 이동](#trade-section-top1)
---
</details>

<a name="trade-section-top2"></a>
<details>
<summary>🏠 메인화면</summary>


![MetroHouse](https://github.com/pingpingeee/Ink_Tree_Pjt/blob/main/lib/images/front/2_1메인.png?raw=true)

1. 토큰
로그인시 사용자의 **토큰 만료시간**과 해당 **토큰의 만료값을 초기화**시켜 다시 30분의 시간을 가지도록 구현하였습니다.
UI상 창모드 및 모바일로 사용 시 사용자경험을 상승시키기 위해 축소 및 일정 width이하가 되면 숨김처리 되도록 구현하였습니다.
2. 검색

---

![MetroHouse](https://github.com/pingpingeee/Ink_Tree_Pjt/blob/main/lib/images/front/2_2메인.png?raw=true)


### 🔝 [이 섹션 맨 위로 이동](#trade-section-top2)
---
</details>

<a name="trade-section-top3"></a>
<details>
<summary>📣 게시판</summary>

![MetroHouse](https://github.com/pingpingeee/Ink_Tree_Pjt/blob/main/lib/images/front/3_1게시판.png?raw=true)

![MetroHouse](https://github.com/pingpingeee/Ink_Tree_Pjt/blob/main/lib/images/front/3_2게시글.png?raw=true)

### 🔝 [이 섹션 맨 위로 이동](#trade-section-top3)
---
</details>

<a name="trade-section-top4"></a>
<details>
<summary>📌 아파트</summary>

![MetroHouse](https://github.com/pingpingeee/Ink_Tree_Pjt/blob/main/lib/images/front/4_1관심아파트.png?raw=true)

### 🔝 [이 섹션 맨 위로 이동](#trade-section-top4)
---
</details>

<a name="trade-section-top5"></a>
<details>
<summary>마이페이지</summary>

![MetroHouse](https://github.com/pingpingeee/Ink_Tree_Pjt/blob/main/lib/images/front/5_1마이페이지.png?raw=true)
  
### 🔝 [이 섹션 맨 위로 이동](#trade-section-top5)
---
</details>

<a name="trade-section-top6"></a>
<details>
<summary>🛠 관리자 기능</summary>

![MetroHouse](https://github.com/pingpingeee/Ink_Tree_Pjt/blob/main/lib/images/front/6_1관리자전용데이터다운로드.png?raw=true)

![MetroHouse](https://github.com/pingpingeee/Ink_Tree_Pjt/blob/main/lib/images/front/6_2최신 아파트 거래 데이터 다운.png?raw=true)

![MetroHouse](https://github.com/pingpingeee/Ink_Tree_Pjt/blob/main/lib/images/front/6_3과거 데이터 큐테이블에 저장.png?raw=true)

![MetroHouse](https://github.com/pingpingeee/Ink_Tree_Pjt/blob/main/lib/images/front/6_4과거 데이터 테이블화(년별로).png?raw=true)

![MetroHouse](https://github.com/pingpingeee/Ink_Tree_Pjt/blob/main/lib/images/front/6_5큐테이블 데이터 삭제.png?raw=true)

### 🔝 [이 섹션 맨 위로 이동](#trade-section-top6)
---
</details>

<a name="trade-section-top7"></a>
<details>
<summary>아파트 상세 정보</summary>

![MetroHouse](https://github.com/pingpingeee/Ink_Tree_Pjt/blob/main/lib/images/front/7_1아파트상세.png?raw=true)

![MetroHouse](https://github.com/pingpingeee/Ink_Tree_Pjt/blob/main/lib/images/front/7_2아파트상세.png?raw=true)


### 🔝 [이 섹션 맨 위로 이동](#trade-section-top7)
---
</details>

<a name="trade-section-top8"></a>
<details>
<summary>지도 시각화 & 아파트 값 비교</summary>

![MetroHouse](https://github.com/pingpingeee/Ink_Tree_Pjt/blob/main/lib/images/front/8_1지도 전체.png?raw=true)

![MetroHouse](https://github.com/pingpingeee/Ink_Tree_Pjt/blob/main/lib/images/front/8_2지도 비교.png?raw=true)

### 🔝 [이 섹션 맨 위로 이동](#trade-section-top8)
---
</details>
