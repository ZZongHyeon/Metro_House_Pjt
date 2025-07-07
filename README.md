## 📦 개발 환경 구성

| 항목 | 상세 내용 |
|------|------|
| **개발 언어** | Java (JDK 8+), JavaScript |
| **프레임워크** | Spring Boot, Spring MVC |
| **ORM** | MyBatis |
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

| API | 설명 |
|------|------|
| **Naver SMTP** | 이메일 인증 시스템 구현  |
| **Kakao 주소 API** | 회원가입 주소 자동입력  |
| **OAuth2 (Naver, Kakao, Google)** | 소셜 로그인 연동 |
| **공공데이터포털 Open API** | 전국 아파트 실거래가 정보 주기적 수집  |
| **Kakao Map API** | 위도/경도 기반 아파트 위치 시각화 및 반경 기반 검색  |

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

![MetroHouse](https://github.com/pingpingeee/Metro_House_Pjt/blob/main/lib/images/front/1_3이메일인증.png?raw=true)

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


![MetroHouse](https://github.com/pingpingeee/Metro_House_Pjt/blob/main/lib/images/front/2_1메인.png?raw=true)

1. 토큰<br>
로그인시 사용자의 **토큰 만료시간**과 해당 **토큰의 만료값을 초기화**시켜 다시 30분의 시간을 가지도록 구현하였습니다.<br>
UI상 창모드 및 모바일로 사용 시 사용자경험을 상승시키기 위해 축소 및 일정 width이하가 되면 숨김처리 되도록 구현하였습니다.
2. 검색<br>
시 → 구/군 → 지하철역 순의 **계층적 드릴다운 방식**으로 지역을 탐색할 수 있는 검색 기능을 제공합니다.<br>
사용자가 특정 시를 선택하면 해당 시에 속한 **구/군 목록**이 자동으로 표시되며,
구/군을 선택하면 해당 지역을 지나는 **지하철역 목록**이 동적으로 제공됩니다.
---

![MetroHouse](https://github.com/pingpingeee/Metro_House_Pjt/blob/main/lib/images/front/2_2메인.png?raw=true)

1. 아래와 같은 지표를 시각적으로 제공합니다.
   - 전체 등록 아파트 수
   - 등록된 지하철역 수
   - 전체 아파트의 평균 매매가
   - 일일 방문자 수
2. 회원가입 시 등록한 **사용자의 주소를 기반**으로 해당 지역 인근 **추천 아파트 3곳이 자동으로 제공**됩니다.

### 🔝 [이 섹션 맨 위로 이동](#trade-section-top2)
---
</details>

<a name="trade-section-top3"></a>
<details>
<summary>📣 게시판</summary>

![MetroHouse](https://github.com/pingpingeee/Metro_House_Pjt/blob/main/lib/images/front/3_1게시판.png?raw=true)

1. 게시판은 커뮤니티 기능의 중심이 되는 구성 요소로 데이터가 많아질수록 성능과 사용 편의성에 영향을 주기 때문에 **페이지당 10개씩** 불러오는 페이징 처리를 적용하여 초기 로딩 속도와 데이터 접근 효율성을 개선하였습니다.
2. 게시글 목록에서는 추천 수와 댓글 수를 사전 노출 하여 사용자가 리스트를 탐색하면서도 활발한 게시글, 인기 게시글을 직관적으로 파악할 수 있도록 UI/UX를 강화하였습니다.
3. **다양한 검색 조건**을 적용할 수 있도록 제목, 본문 내용, 작성자 기준의 검색 기능을 구현하였습니다.
4. 이로 인해 사용자는 키워드 기반으로 빠르고 정확하게 원하는 게시글을 탐색할 수 있습니다.

---
   
![MetroHouse](https://github.com/pingpingeee/Metro_House_Pjt/blob/main/lib/images/front/3_2게시글.png?raw=true)

1. 게시글 상세 기능에서는 사용자의 반응을 유도하고 콘텐츠의 신뢰도를 높이기 위해 추천 기능을 도입하였습니다.
2. 사용자는 특정 게시글에 공감하거나 유익하다고 판단될 경우 **추천 버튼**을 통해 피드백을 줄 수 있으며 이는 커뮤니티 내에서 콘텐츠 품질을 자연스럽게 평가할 수 있는 간접적인 장치로 작용합니다.
3. 댓글 시스템에서는 **계층형 구조**를 구현하기 위해 SubNumber 컬럼을 활용하였습니다.
4. 댓글 작성 시 부모 댓글의 ID와 함께 계층 구조를 판단할 수 있도록 설계하여 일반 댓글과 대댓글의 관계를 명확하게 구분하고 프론트엔드에서는 이를 바탕으로 들여쓰기 형식의 계층 UI를 구현할 수 있게 하였습니다.

### 🔝 [이 섹션 맨 위로 이동](#trade-section-top3)
---
</details>

<a name="trade-section-top4"></a>
<details>
<summary>📌 관심 아파트</summary>

![MetroHouse](https://github.com/pingpingeee/Metro_House_Pjt/blob/main/lib/images/front/4_1관심아파트.png?raw=true)

1. 아파트 상세 페이지 및 지도 기반 인터페이스에서 **관심 아파트 등록 기능**을 제공합니다.
2. **지역 / 가격 범위 / 정렬 기준(최근 등록순, 가격 낮은순, 가격 높은순, 면적 작은순, 면적 큰순)** 을 통하여 아파트를 효율적으로 검색할 수 있습니다.
3. 상세보기 버튼 클릭 시, 해당 아파트의 **상세 정보 페이지로 즉시 이동**할 수 있습니다.

### 🔝 [이 섹션 맨 위로 이동](#trade-section-top4)
---
</details>

<a name="trade-section-top5"></a>
<details>
<summary>👤 마이페이지</summary>

![MetroHouse](https://github.com/pingpingeee/Metro_House_Pjt/blob/main/lib/images/front/5_1마이페이지.png?raw=true)

1. 사용자는 마이페이지를 통해 **개인정보 및 비밀번호를 수정**할 수 있습니다.
2. 보안 강화를 위해 **현재 비밀번호 입력 및 일치 여부 확인 후 변경이 가능**하도록 설계되어 있습니다.
  
### 🔝 [이 섹션 맨 위로 이동](#trade-section-top5)
---
</details>

<a name="trade-section-top6"></a>
<details>
<summary>🛠 관리자 기능</summary>

![MetroHouse](https://github.com/pingpingeee/Metro_House_Pjt/blob/main/lib/images/front/6_1관리자전용데이터다운로드.png?raw=true)

1. **최신데이터 다운로드**: 실시간 API를 통해 **가장 최신의 실거래가 데이터**를 APRATMENTINFO 테이블에 저장합니다.
2. **과거 데이터 다운로드**: 관리자가 원하는 **관거 연도 수를 입력**하면, 매년 1월 기준의 과거 데이터를 API에서 수집하여 APARTMENTINFO_QUEUE 테이블에 저장합니다.
3. **데이터 동기화**: 저장된 데이터를 **연도 기준으로 분할 테이블로 구성**합니다.
4. **큐 데이터 정리**: 분할 테이블 생성 후 APRATMENTINF_OQUEUE테이블의 데이터를 삭제하여 **DB최적화**를 수행합니다.

---

![MetroHouse](https://github.com/pingpingeee/Metro_House_Pjt/blob/main/lib/images/front/6_2최신_아파트_거래_데이터_다운.png?raw=true)

🔝 [이 섹션 맨 위로 이동](#trade-section-top6)

![MetroHouse](https://github.com/pingpingeee/Metro_House_Pjt/blob/main/lib/images/front/6_3과거_데이터_큐테이블에_저장.png?raw=true)

🔝 [이 섹션 맨 위로 이동](#trade-section-top6)

![MetroHouse](https://github.com/pingpingeee/Metro_House_Pjt/blob/main/lib/images/front/6_4과거_데이터_테이블화(년별로).png?raw=true)

🔝 [이 섹션 맨 위로 이동](#trade-section-top6)

![MetroHouse](https://github.com/pingpingeee/Metro_House_Pjt/blob/main/lib/images/front/6_5큐테이블_데이터_삭제.png?raw=true)


### 🔝 [이 섹션 맨 위로 이동](#trade-section-top6)
---
</details>

<a name="trade-section-top7"></a>
<details>
<summary>🏢 아파트 상세 정보</summary>

![MetroHouse](https://github.com/pingpingeee/Metro_House_Pjt/blob/main/lib/images/front/7_1아파트상세.png?raw=true)

1. 페이지 진입 시 해당 아파트의 기본 정보와 **그래프로 표현한 년별 가격**이 최우선으로 노출됩니다.
2. 사용자는 아파트에 대해 **관심 등록 기능**을 이용할 수 있습니다.
3. 사용자는 각 아파트에 대해 **한 번만 리뷰**를 작성할 수 있으며, 자신의 리뷰는 수정 및 삭제가 가능합니다.
4. 리뷰 평균 평점은 상단에 시각적으로 **집계**되어 표시되며, 전체 이용자의 평가 흐름을 한눈에 확인할 수 있습니다.
5. 관리자는 모든 리뷰에 대해 **제한 없이 수정 및 삭제 권한**을 갖습니다.

---

![MetroHouse](https://github.com/pingpingeee/Metro_House_Pjt/blob/main/lib/images/front/7_2아파트상세.png?raw=true)


### 🔝 [이 섹션 맨 위로 이동](#trade-section-top7)
---
</details>

<a name="trade-section-top8"></a>
<details>
<summary>🗺️ 지도 시각화 & 아파트 값 비교</summary>

![MetroHouse](https://github.com/pingpingeee/Metro_House_Pjt/blob/main/lib/images/front/8_1지도_전체.png?raw=true)

1. 메인 화면에서의 **지하철역 검색을 기반으로 주변 아파트 위치를 지도에 시각화**할 수 있습니다.
2. 해당 지하철역 인근 내 **실거래가 기반 아파트 데이터**가 지도와 리스트로 동시 표현됩니다.
3. 좌측에는 사용자가 **관심 등록한 아파트 리스트**가 표현됩니다.
4. 우측에는 **해당 지하철역 인근 아파트 리스트**가 표현되고, 콜릭 시 지도에 상세 정보 카드가 출력됩니다.
5. 관심 아파트는 실시간으로 **등록 / 삭제 가능**하며, 각 리스트는 상호 연동됩니다.

---

![MetroHouse](https://github.com/pingpingeee/Metro_House_Pjt/blob/main/lib/images/front/8_2지도_비교.png?raw=true)

1. 우측 리스트에서 선택한 아파트 카드는 **좌측 상단의 고정 영역**에 등록되고 지도에서도 카드로 표현됩니다.
2. 등록된 아파트는 사용자 관심 아파트 목록과 **비교 가능한 형식으로 시각화**되어, **면적, 가격, 위치 등 주요 정보를 한눈에 확인**할 수 있습니다.

### 🔝 [이 섹션 맨 위로 이동](#trade-section-top8)
---
</details>
