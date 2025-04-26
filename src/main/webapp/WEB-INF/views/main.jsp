<%@page import="com.boot.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>메트로하우스 - 지하철역 주변 아파트 시세</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="/resources/css/main.css">
<link rel="stylesheet" type="text/css"
	href="/resources/css/book_search.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    // 폼 제출 시 엔터 입력을 막고 fn_submit 호출
    $("#search-form").on("submit", function(e) {
        e.preventDefault();  // 새로고침 방지
        fn_submit();         // 검색 함수 호출
    });
});

function fn_submit() {
    var formData = $("#search-form").serialize(); // 모든 폼 요소 직렬화
    $.ajax({
        type: "GET",
        url: "apartment_search_view",
        data: formData,
        success: function(data) {
            // 결과 페이지로 이동하거나, 결과를 동적으로 처리해도 OK
            location.href = "apartment_search_view?" + formData;
        },
        error: function(xhr) {
            alert("검색 요청 중 오류가 발생했습니다.");
        }
    });
}
</script>
</head>
<body>
	<jsp:include page="header.jsp" />
	<div class="container">
		<%
		UserDTO user = (UserDTO) session.getAttribute("loginUser");
		if (user != null) {
		%>

		<div class="slider-container">
			<div class="image-slider">
				<div class="slide">
					<img src="/resources/images/main1.png" alt="슬라이드 1">
				</div>
				<div class="slide">
					<img src="/resources/images/main2.png" alt="슬라이드 2">
				</div>
				<div class="slide">
					<img src="../resources/images/main3.png" alt="슬라이드 3">
				</div>
				<div class="slide">
					<img src="../resources/images/main4.png" alt="슬라이드 4">
				</div>
				<div class="slide">
					<img src="../resources/images/main5.png" alt="슬라이드 5">
				</div>
			</div>
			<!-- 슬라이더 인디케이터 추가 -->
			<div class="slider-indicators">
				<div class="indicator active" data-index="0"></div>
				<div class="indicator" data-index="1"></div>
				<div class="indicator" data-index="2"></div>
				<div class="indicator" data-index="3"></div>
				<div class="indicator" data-index="4"></div>
			</div>
		</div>

		<div class="welcome-banner">
			<div class="welcome-text">
				<h1>
					안녕하세요, <%=user.getUserName()%>님!
				</h1>
				<p>메트로하우스 지하철역 주변 아파트 시세 서비스에 오신 것을 환영합니다.</p>
			</div>
			<div class="date-display">
				<i class="fas fa-calendar-alt"></i> <span id="current-date">
					<%=new java.text.SimpleDateFormat("yyyy년 MM월 dd일 EEEE", java.util.Locale.KOREAN).format(new java.util.Date())%>
				</span>
			</div>
		</div>

		<div class="search-header">
			<h1 class="search-title">
				<i class="fas fa-building"></i> 아파트 검색
			</h1>

			<form class="search-form" id="search-form">
				<!-- 메인 검색창 -->
				<div class="search-main">
					<input type="text" class="search-input-main" id="searchKeyword"
						name="searchKeyword" value="${param.searchKeyword}"
						placeholder="지하철역, 아파트명, 동네 이름을 입력하세요">
					<button type="button" class="search-button-main"
						onclick="fn_submit()">
						<i class="fas fa-search"></i>
					</button>
				</div>

				<!-- 필터 옵션 -->
				<div class="search-filters">
					<div class="search-filter">
						<label class="filter-label" for="searchType">검색 유형</label> <select
							class="filter-select" id="searchType" name="searchType">
							<option value="station"
								${param.searchType == 'station' ? 'selected' : ''}>지하철역</option>
							<option value="apartment"
								${param.searchType == 'apartment' ? 'selected' : ''}>아파트명</option>
							<option value="district"
								${param.searchType == 'district' ? 'selected' : ''}>지역구</option>
							<option value="dong"
								${param.searchType == 'dong' ? 'selected' : ''}>동네</option>
						</select>
					</div>

					<div class="search-filter">
						<label class="filter-label" for="majorCategory">지역</label> <select
							class="filter-select" id="majorCategory" name="majorCategory">
							<option value="">전체</option>
							<option value="강남구"
								${param.majorCategory == '강남구' ? 'selected' : ''}>강남구</option>
							<option value="강동구"
								${param.majorCategory == '강동구' ? 'selected' : ''}>강동구</option>
							<option value="강북구"
								${param.majorCategory == '강북구' ? 'selected' : ''}>강북구</option>
							<option value="강서구"
								${param.majorCategory == '강서구' ? 'selected' : ''}>강서구</option>
							<option value="관악구"
								${param.majorCategory == '관악구' ? 'selected' : ''}>관악구</option>
							<option value="광진구"
								${param.majorCategory == '광진구' ? 'selected' : ''}>광진구</option>
							<option value="구로구"
								${param.majorCategory == '구로구' ? 'selected' : ''}>구로구</option>
							<option value="금천구"
								${param.majorCategory == '금천구' ? 'selected' : ''}>금천구</option>
							<option value="노원구"
								${param.majorCategory == '노원구' ? 'selected' : ''}>노원구</option>
							<option value="도봉구"
								${param.majorCategory == '도봉구' ? 'selected' : ''}>도봉구</option>
						</select>
					</div>

					<div class="search-filter">
						<label class="filter-label" for="subCategory">지하철 노선</label> <select
							class="filter-select" id="subCategory" name="subCategory">
							<option value="">전체</option>
							<!-- 지역에 따라 동적으로 변경될 수 있습니다 -->
						</select>
					</div>
				</div>
			</form>
		</div>

		<!-- Statistics Dashboard -->
		<div class="stats-dashboard">
			<div class="stat-card">
				<div class="stat-icon books">
					<i class="fas fa-building"></i>
				</div>
				<div class="stat-info">
					<h3>전체 아파트</h3>
					<div class="number">
						<fmt:formatNumber value="${totalApartments}" type="number" />
					</div>
				</div>
			</div>

			<div class="stat-card">
				<div class="stat-icon users">
					<i class="fas fa-subway"></i>
				</div>
				<div class="stat-info">
					<h3>전체 지하철역</h3>
					<div class="number">
						<fmt:formatNumber value="${totalStations}" type="number" />
					</div>
				</div>
			</div>

			<div class="stat-card">
				<div class="stat-icon borrowed">
					<i class="fas fa-chart-line"></i>
				</div>
				<div class="stat-info">
					<h3>평균 매매가</h3>
					<div class="number">
						<fmt:formatNumber value="${averagePrice}" type="number" />
					</div>
				</div>
			</div>

			<div class="stat-card">
				<div class="stat-icon overdue">
					<i class="fas fa-search-location"></i>
				</div>
				<div class="stat-info">
					<h3>오늘 조회수</h3>
					<div class="number">
						<fmt:formatNumber value="${todayViews}" type="number" />
					</div>
				</div>
			</div>
		</div>

		<!-- Smaller Feature Cards -->
		<div class="feature-section">
			<div class="feature-card">
				<div class="feature-icon">
					<i class="fas fa-heart"></i>
				</div>
				<div class="feature-content">
					<h3>관심 아파트</h3>
					<p>관심 있는 아파트의 시세 변동을 확인하세요.</p>
					<a href="user_favorite_apartments" class="btn-sm">바로가기</a>
				</div>
			</div>

			<div class="feature-card">
				<div class="feature-icon">
					<i class="fas fa-map-marked-alt"></i>
				</div>
				<div class="feature-content">
					<h3>지도 검색</h3>
					<p>지도에서 원하는 지역의 아파트 시세를 확인하세요.</p>
					<a href="map_search_view" class="btn-sm">바로가기</a>
				</div>
			</div>

			<div class="feature-card">
				<div class="feature-icon">
					<i class="fas fa-star"></i>
				</div>
				<div class="feature-content">
					<h3>추천 아파트</h3>
					<p>회원님의 관심사에 맞는 아파트를 추천해 드립니다.</p>
					<a href="user_apartment_recommend" class="btn-sm">바로가기</a>
				</div>
			</div>
		</div>

		<!-- Recommended Apartments -->
		<div class="recommended-books">
			<div class="section-header">
				<h2 class="section-title">
					<i class="fas fa-thumbs-up"></i> 추천 아파트
				</h2>
				<a href="/recommended_apartments" class="action-link"> 더보기
					<i class="fas fa-chevron-right"></i>
				</a>
			</div>


			<div class="books-grid">
				<c:forEach var="apartment" items="${apartmentList}" varStatus="status">
					<c:if test="${status.index <4}">
						<div class="book-card">
							<div class="book-cover">
								<div class="book-cover-placeholder">
									<i class="fas fa-building"></i>
								</div>
							</div>
							<div class="book-info">
								<h3 class="book-title">${apartment.apartmentName}</h3>
								<div class="book-author">지역: ${apartment.district} ${apartment.dong}</div>
								<div class="book-publisher">가까운 역: ${apartment.nearestStation}</div>
								<div class="book-date">
									건축년도:
									<fmt:formatDate value="${apartment.builtDate}"
										pattern="yyyy년" />
								</div>

								<div class="book-categories">
									<span class="book-category">${apartment.size}㎡</span>
									<c:if test="${not empty apartment.floor}">
										<span class="book-category">${apartment.floor}층</span>
									</c:if>
								</div>

								<div class="book-status">
									<div class="book-availability available">
										<i class="fas fa-won-sign"></i> 
										<fmt:formatNumber value="${apartment.price}" type="number" />만원
									</div>
									<a href="/apartment_detail?apartmentId=${apartment.apartmentId}"
										class="book-detail-button">상세보기</a>
								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>

		<%
		} else {
		%>
		<div class="login-section">
			<h2>메트로하우스에 오신 것을 환영합니다</h2>
			<p>
				메트로하우스는 지하철역 주변 아파트 시세를 확인할 수 있는 서비스를 제공합니다.<br>서비스를
				이용하시려면 로그인이 필요합니다.
			</p>
			<a href="/loginView" class="btn"> <i
				class="fas fa-sign-in-alt"></i> 로그인 하러 가기
			</a>
			<p style="margin-top: 20px;">
				계정이 없으신가요? <a href="joinView">회원가입</a>
			</p>
		</div>
		<%
		}
		%>
	</div>


	<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Animate statistics numbers
        const statNumbers = document.querySelectorAll('.number');
        
        statNumbers.forEach(number => {
            const finalValue = number.textContent;
            let startValue = 0;
            const duration = 1500;
            const increment = parseInt(finalValue.replace(/,/g, '')) / (duration / 20);
            
            const animateValue = () => {
                startValue += increment;
                if (startValue < parseInt(finalValue.replace(/,/g, ''))) {
                    number.textContent = Math.floor(startValue).toLocaleString();
                    requestAnimationFrame(animateValue);
                } else {
                    number.textContent = finalValue;
                }
            };
            
            requestAnimationFrame(animateValue);
        });
        
        // 슬라이더 인디케이터 기능 추가
        const indicators = document.querySelectorAll('.indicator');
        const slides = document.querySelectorAll('.slide');
        
        indicators.forEach(indicator => {
            indicator.addEventListener('click', function() {
                const index = this.getAttribute('data-index');
                
                // 모든 슬라이드와 인디케이터에서 active 클래스 제거
                slides.forEach(slide => slide.classList.remove('active'));
                indicators.forEach(ind => ind.classList.remove('active'));
                
                // 선택한 슬라이드와 인디케이터에 active 클래스 추가
                slides[index].classList.add('active');
                this.classList.add('active');
            });
        });
        
        // 지역에 따른 지하철 노선 옵션 변경
        document.getElementById('majorCategory').addEventListener('change', function() {
            const majorCategory = this.value;
            const subCategorySelect = document.getElementById('subCategory');
            
            // 기존 옵션 제거
            subCategorySelect.innerHTML = '<option value="">전체</option>';
            
            // 지역에 따른 지하철 노선 옵션 추가
            if (majorCategory === '강남구') {
                addSubCategories(['2호선', '3호선', '신분당선', '9호선']);
            } else if (majorCategory === '강동구') {
                addSubCategories(['5호선', '8호선', '9호선']);
            } else if (majorCategory === '강북구') {
                addSubCategories(['4호선', '7호선']);
            } else if (majorCategory === '강서구') {
                addSubCategories(['5호선', '9호선', '공항철도']);
            } else if (majorCategory === '관악구') {
                addSubCategories(['2호선', '7호선']);
            } else if (majorCategory === '광진구') {
                addSubCategories(['2호선', '5호선', '7호선']);
            } else if (majorCategory === '구로구') {
                addSubCategories(['1호선', '2호선', '7호선']);
            } else if (majorCategory === '금천구') {
                addSubCategories(['1호선', '7호선']);
            } else if (majorCategory === '노원구') {
                addSubCategories(['4호선', '7호선', '경춘선']);
            } else if (majorCategory === '도봉구') {
                addSubCategories(['1호선', '4호선', '7호선']);
            }
            
            // 현재 URL에서 선택된 소분류가 있으면 선택 상태로 만들기
            const urlParams = new URLSearchParams(window.location.search);
            const selectedSubCategory = urlParams.get('subCategory');
            if (selectedSubCategory) {
                for (let i = 0; i < subCategorySelect.options.length; i++) {
                    if (subCategorySelect.options[i].value === selectedSubCategory) {
                        subCategorySelect.options[i].selected = true;
                        break;
                    }
                }
            }
        });
        
        // 소분류 옵션 추가 함수
        function addSubCategories(categories) {
            const subCategorySelect = document.getElementById('subCategory');
            categories.forEach(category => {
                const option = document.createElement('option');
                option.value = category;
                option.textContent = category;
                subCategorySelect.appendChild(option);
            });
        }
        
        // 페이지 로드 시 대분류에 따른 소분류 설정
        window.addEventListener('DOMContentLoaded', function() {
            const majorCategorySelect = document.getElementById('majorCategory');
            if (majorCategorySelect.value) {
                majorCategorySelect.dispatchEvent(new Event('change'));
            }
        });
        
        // 정렬 기능
        function sortApartments(sortType) {
            // 정렬 버튼 활성화 상태 변경
            document.querySelectorAll('.sort-button').forEach(button => {
                button.classList.remove('active');
            });
            event.target.classList.add('active');
            
            // 실제 구현 시 서버로 정렬 요청을 보내거나 클라이언트에서 정렬 처리
            const currentUrl = new URL(window.location.href);
            currentUrl.searchParams.set('sort', sortType);
            window.location.href = currentUrl.toString();
        }
        
        // 슬라이드
        $(document).ready(function() {
            // 첫 번째 슬라이드 활성화
            $('.slide:first-child').addClass('active');
            
            // 슬라이드 자동 전환 함수
            function nextSlide() {
                var currentSlide = $('.slide.active');
                var nextSlide = currentSlide.next('.slide').length ? currentSlide.next('.slide') : $('.slide:first-child');
                
                // 인디케이터도 함께 업데이트
                var currentIndex = $('.slide').index(currentSlide);
                var nextIndex = $('.slide').index(nextSlide);
                
                $('.indicator').removeClass('active');
                $('.indicator[data-index="' + nextIndex + '"]').addClass('active');
                
                currentSlide.removeClass('active');
                nextSlide.addClass('active');
            }
            
            // 3초마다 슬라이드 전환
            setInterval(nextSlide, 3000);
        });
    </script>
</body>
</html>