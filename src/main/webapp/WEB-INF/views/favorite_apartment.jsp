<%@page import="com.boot.user.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관심 아파트 - 메트로하우스</title>
    <link rel="stylesheet" type="text/css"
	href="/resources/css/favorite_apartment.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
   
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container">
        <div class="page-header">
            <h1 class="page-title"><i class="fas fa-heart"></i> 관심 아파트</h1>
            <p class="page-subtitle">회원님이 관심 등록한 아파트 목록입니다. 가격 변동 및 상세 정보를 확인하고 비교해보세요.</p>
            <div class="bubble-animation">
                <div class="bubble"></div>
                <div class="bubble"></div>
                <div class="bubble"></div>
            </div>
        </div>

        <div class="filter-section">
            <div class="filter-header">
                <h2 class="filter-title"><i class="fas fa-filter"></i> 필터</h2>
                <div class="filter-controls">
                    <button class="filter-reset"><i class="fas fa-undo"></i> 초기화</button>
                    <button class="filter-button"><i class="fas fa-search"></i> 검색</button>
                </div>
            </div>
            <div class="filter-row">
                <div class="filter-group">
                    <label class="filter-label">지역</label>
                    <select class="filter-select" id="regionSelect">
                        <option value="">전체</option>
                        <option value="서울">서울특별시</option>
                        <option value="경기">경기도</option>
                        <option value="인천">인천광역시</option>
                        <option value="부산">부산광역시</option>
                        <option value="대전">대전광역시</option>
                        <option value="대구">대구광역시</option>
                        <option value="광주">광주광역시</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label class="filter-label">구/군</label>
                    <select class="filter-select" id="districtSelect">
                        <option value="">전체</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label class="filter-label">가격 범위</label>
                    <select class="filter-select">
                        <option value="">전체</option>
                        <option value="0-50000">5억 이하</option>
                        <option value="50000-100000">5억-10억</option>
                        <option value="100000-150000">10억-15억</option>
                        <option value="150000+">15억 이상</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label class="filter-label">정렬</label>
                    <select class="filter-select">
                        <option value="recent">최근 등록순</option>
                        <option value="price-asc">가격 낮은순</option>
                        <option value="price-desc">가격 높은순</option>
                        <option value="size-asc">면적 작은순</option>
                        <option value="size-desc">면적 큰순</option>
                    </select>
                </div>
            </div>
        </div>

        <% 
        // 관심 아파트가 있는지 확인
        Object favoriteCountObj = request.getAttribute("userFavoriteCount");
        //int favoriteCount = 0;
        int favoriteCount = 1;
        if (favoriteCountObj != null) {
            try {
                favoriteCount = Integer.parseInt(String.valueOf(favoriteCountObj));
            } catch (NumberFormatException e) {
                // 변환 실패 시 기본값 유지
            }
        }
        
        if (favoriteCount > 0) {
        %>
        <div class="apartment-grid">
            <%-- 실제 데이터가 있을 때는 이 부분이 표시됨 --%>
            <c:forEach var="apartment" items="${favoriteApartments}" varStatus="status">
                <div class="apartment-card">
                    <div class="apartment-image">
                        <img src="/resources/images/apartments/${apartment.apartmentId}.jpg" 
                             onerror="this.src='/resources/images/apartment-placeholder.jpg'" 
                             alt="${apartment.apartmentName}">
                        <div class="apartment-favorite" onclick="removeFavorite('${apartment.apartmentId}')">
                            <i class="fas fa-heart"></i>
                        </div>
                        <div class="apartment-badge">관심 등록</div>
                    </div>
                    <div class="apartment-content">
                        <h3 class="apartment-title">${apartment.apartmentName}</h3>
                        <div class="apartment-location">
                            <i class="fas fa-map-marker-alt"></i>
                            ${apartment.district} ${apartment.dong}
                        </div>
                        <div class="apartment-details">
                            <div class="detail-item">
                                <span class="detail-label">면적</span>
                                <span class="detail-value">${apartment.size}㎡</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">층수</span>
                                <span class="detail-value">${not empty apartment.floor ? apartment.floor : '-'}층</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">건축년도</span>
                                <span class="detail-value">
                                    <fmt:formatDate value="${apartment.builtDate}" pattern="yyyy년" />
                                </span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">가까운 역</span>
                                <span class="detail-value">${apartment.nearestStation}</span>
                            </div>
                        </div>
                        <div class="apartment-price">
                            <div>
                                <span class="price-value">
                                    <fmt:formatNumber value="${apartment.price}" type="number"/>
                                </span>
                                <span class="price-unit">만원</span>
                            </div>
                            <a href="/apartment_detail?apartmentId=${apartment.apartmentId}" class="apartment-button">
                                <i class="fas fa-info-circle"></i> 상세보기
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <%-- 아래는 더미 데이터 아파트 카드 --%>
            <%-- 아파트 1 --%>
            <div class="apartment-card">
                <div class="apartment-image">
                    <img src="/resources/images/main3.png" 
                         alt="래미안 펠리스">
                    <div class="apartment-favorite" onclick="removeFavorite('AP001')">
                        <i class="fas fa-heart"></i>
                    </div>
                    <div class="apartment-badge">관심 등록</div>
                </div>
                <div class="apartment-content">
                    <h3 class="apartment-title">래미안 펠리스</h3>
                    <div class="apartment-location">
                        <i class="fas fa-map-marker-alt"></i>
                        서울특별시 강남구 대치동
                    </div>
                    <div class="apartment-details">
                        <div class="detail-item">
                            <span class="detail-label">면적</span>
                            <span class="detail-value">84.5㎡</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">층수</span>
                            <span class="detail-value">15층</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">건축년도</span>
                            <span class="detail-value">2019년</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">가까운 역</span>
                            <span class="detail-value">대치역</span>
                        </div>
                    </div>
                    <div class="apartment-price">
                        <div>
                            <span class="price-value">185,000</span>
                            <span class="price-unit">만원</span>
                        </div>
                        <a href="/apartment_detail?apartmentId=AP001" class="apartment-button">
                            <i class="fas fa-info-circle"></i> 상세보기
                        </a>
                    </div>
                </div>
            </div>
            
            <%-- 아파트 2 --%>
            <div class="apartment-card">
                <div class="apartment-image">
                    <img src="/resources/images/main2.png" 
                         alt="푸르지오 시티">
                    <div class="apartment-favorite" onclick="removeFavorite('AP002')">
                        <i class="fas fa-heart"></i>
                    </div>
                    <div class="apartment-badge">관심 등록</div>
                </div>
                <div class="apartment-content">
                    <h3 class="apartment-title">푸르지오 시티</h3>
                    <div class="apartment-location">
                        <i class="fas fa-map-marker-alt"></i>
                        서울특별시 송파구 잠실동
                    </div>
                    <div class="apartment-details">
                        <div class="detail-item">
                            <span class="detail-label">면적</span>
                            <span class="detail-value">101.2㎡</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">층수</span>
                            <span class="detail-value">21층</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">건축년도</span>
                            <span class="detail-value">2020년</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">가까운 역</span>
                            <span class="detail-value">잠실역</span>
                        </div>
                    </div>
                    <div class="apartment-price">
                        <div>
                            <span class="price-value">210,000</span>
                            <span class="price-unit">만원</span>
                        </div>
                        <a href="/apartment_detail?apartmentId=AP002" class="apartment-button">
                            <i class="fas fa-info-circle"></i> 상세보기
                        </a>
                    </div>
                </div>
            </div>
            
            <%-- 아파트 3 --%>
            <div class="apartment-card">
                <div class="apartment-image">
                    <img src="/resources/images/main1.png" 
                         alt="자이 아파트">
                    <div class="apartment-favorite" onclick="removeFavorite('AP003')">
                        <i class="fas fa-heart"></i>
                    </div>
                    <div class="apartment-badge">관심 등록</div>
                </div>
                <div class="apartment-content">
                    <h3 class="apartment-title">자이 아파트</h3>
                    <div class="apartment-location">
                        <i class="fas fa-map-marker-alt"></i>
                        경기도 성남시 분당구
                    </div>
                    <div class="apartment-details">
                        <div class="detail-item">
                            <span class="detail-label">면적</span>
                            <span class="detail-value">76.8㎡</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">층수</span>
                            <span class="detail-value">12층</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">건축년도</span>
                            <span class="detail-value">2018년</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">가까운 역</span>
                            <span class="detail-value">서현역</span>
                        </div>
                    </div>
                    <div class="apartment-price">
                        <div>
                            <span class="price-value">138,000</span>
                            <span class="price-unit">만원</span>
                        </div>
                        <a href="/apartment_detail?apartmentId=AP003" class="apartment-button">
                            <i class="fas fa-info-circle"></i> 상세보기
                        </a>
                    </div>
                </div>
            </div>
        </div>

<!--		페이징 실제 구현 필요-->
<!--        <div class="pagination">-->
<!--            <div class="page-item disabled">-->
<!--                <a class="page-link" href="#" aria-label="Previous">-->
<!--                    <i class="fas fa-chevron-left"></i>-->
<!--                </a>-->
<!--            </div>-->
<!--            <div class="page-item active">-->
<!--                <a class="page-link" href="#">1</a>-->
<!--            </div>-->
<!--            <div class="page-item">-->
<!--                <a class="page-link" href="#">2</a>-->
<!--            </div>-->
<!--            <div class="page-item">-->
<!--                <a class="page-link" href="#">3</a>-->
<!--            </div>-->
<!--            <div class="page-item">-->
<!--                <a class="page-link" href="#" aria-label="Next">-->
<!--                    <i class="fas fa-chevron-right"></i>-->
<!--                </a>-->
<!--            </div>-->
<!--        </div>-->
        <% } else { %>
        <div class="empty-state">
            <div class="empty-icon">
                <i class="fas fa-heart"></i>
            </div>
            <div class="emoji-box">
                <span class="emoji">🏢</span>
                <span class="emoji-text">아직 관심 등록한 아파트가 없어요!</span>
            </div>
            <p class="empty-description">
                관심있는 아파트를 등록하면 이곳에서 한눈에 확인하고<br> 가격 변동 알림을 받을 수 있습니다.
                지금 마음에 드는 아파트를 찾아볼까요?
            </p>
            <a href="/apartment_search_view" class="empty-button">
                <i class="fas fa-search"></i> 아파트 검색하기
            </a>
        </div>
        <% } %>
    </div>

    <script>
        // 지역별 구/군 데이터
        const districtData = {
            '서울': ['강남구', '서초구', '송파구', '강동구', '강북구', '강서구', '관악구', '광진구', '구로구', '금천구', '노원구', '도봉구', '동대문구', '동작구', '마포구', '서대문구', '성동구', '성북구', '양천구', '영등포구', '용산구', '은평구', '종로구', '중구', '중랑구'],
            '경기': ['수원시', '성남시', '고양시', '용인시', '부천시', '안산시', '안양시', '남양주시', '화성시', '평택시', '의정부시', '시흥시', '파주시', '광명시', '김포시', '군포시', '광주시', '이천시', '양주시', '오산시', '구리시', '안성시', '포천시', '의왕시', '하남시', '여주시', '양평군', '동두천시', '과천시', '가평군', '연천군'],
            '인천': ['중구', '동구', '미추홀구', '연수구', '남동구', '부평구', '계양구', '서구', '강화군', '옹진군'],
            '부산': ['강서구','북구','사상구','사하구','동래구','연제구','금정구','부산진구','중구','영도구','동구','서구','해운대구','수영구','남구','기장군'],
            '대전': ['동구','중구','서구','유성구','대덕구'],
            '대구': ['동구','중구','서구','남구','북구','수성구','달서구','달성군'],
            '광주': ['동구','서구','남구','북구','광산구']
        };

        // 지역 선택 시 구/군 목록 업데이트
        document.getElementById('regionSelect').addEventListener('change', function() {
            const districtSelect = document.getElementById('districtSelect');
            const selectedRegion = this.value;
            
            // 구/군 select 초기화
            districtSelect.innerHTML = '<option value="">전체</option>';
            
            // 선택된 지역에 해당하는 구/군 추가
            if (selectedRegion && districtData[selectedRegion]) {
                districtData[selectedRegion].forEach(district => {
                    const option = document.createElement('option');
                    option.value = district;
                    option.textContent = district;
                    districtSelect.appendChild(option);
                });
            }
        });

        function removeFavorite(apartmentId) {
            if (confirm('정말로 이 아파트를 관심 목록에서 삭제하시겠습니까?')) {
                $.ajax({
                    type: "post",
                    data: { apartmentId: apartmentId },
                    url: "apartment_favorite_remove",
                    success: function(data) {
                        alert("관심 목록에서 삭제되었습니다.");
                        location.reload(); // 페이지 새로고침
                    },
                    error: function() {
                        alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
                    }
                });
            }
        }
        
        // 필터 초기화 버튼
        document.querySelector('.filter-reset').addEventListener('click', function() {
            document.querySelectorAll('.filter-select').forEach(select => {
                select.selectedIndex = 0;
            });
            // 구/군 선택지 초기화
            const districtSelect = document.getElementById('districtSelect');
            districtSelect.innerHTML = '<option value="">전체</option>';
        });
        
        // 필터 검색 버튼
        document.querySelector('.filter-button').addEventListener('click', function() {
            // 실제 구현 시 필터 값을 가져와서 서버로 요청을 보내는 코드 작성
            alert('필터 검색 기능은 현재 개발 중입니다.');
        });
    </script>
</body>
</html>