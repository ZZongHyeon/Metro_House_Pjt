<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>지하철역 주변 아파트 검색 결과 - 메트로하우스</title>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&display=swap"
                rel="stylesheet">
				<!-- 카카오맵 API 스크립트 -->
				<script type="text/javascript"
				    src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoApiKey}&libraries=services"></script>
            <link rel="stylesheet" type="text/css" href="/resources/css/main.css">
            <link rel="stylesheet" type="text/css" href="/resources/css/search_map.css">
			<script src="/resources/js/search_map_marker.js"></script>
            <script src="/resources/js/subway_section.js"></script>
            <script src="/resources/js/main.js"></script>
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        </head>

        <body>
            <jsp:include page="header.jsp" />
			<div class="container">
			        <div class="main-content-wrapper">
			            <div class="comparison-container">
			                <div class="comparison-header">
			                    <i class="fas fa-exchange-alt"></i>
			                    아파트 비교
			                </div>
			                
<!--			                선택된 아파트 정보 -->
			                <div class="selected-apartment" id="selectedApartment">
			                    <p class="no-selection-message">
			                        <i class="fas fa-info-circle"></i> 우측 목록에서 아파트를 선택하세요.
			                    </p>
			                </div>
			                
			                <div class="comparison-divider">
			                    <span>관심 목록과 비교</span>
			                </div>
			                
<!--							관심 목록 아파트-->
							<div class="interest-comparison-list" id="interestComparisonList">
							    <c:choose>
							        <c:when test="${empty interestList}">
							            <p class="no-interest-message">
							                <i class="fas fa-heart"></i> 관심 등록된 아파트가 없습니다.
							            </p>
							        </c:when>
							        <c:otherwise>
							            <c:forEach var="apt" items="${interestList}">
							                <div class="comparison-item" data-apt-id="${apt.apartmentId}">
							                    <div class="comparison-apt-info">
							                        <h3 class="comparison-apt-name">${apt.aptNm}</h3>
							                        <div class="comparison-apt-location">${apt.estateAgentSggNm}</div>
							                    </div>
							                    <div class="comparison-details">
							                        <div class="comparison-detail">
							                            <span class="detail-label">가격</span>
							                            <span class="detail-value">${apt.dealAmount}만원</span>
							                        </div>
							                        <div class="comparison-detail">
							                            <span class="detail-label">평수</span>
							                            <span class="detail-value">${apt.excluUseAr}㎡</span>
							                        </div>
							                        <div class="comparison-detail">
							                            <span class="detail-label">층수</span>
							                            <span class="detail-value">${apt.floor}층</span>
							                        </div>
							                        <div class="comparison-detail">
							                            <span class="detail-label">건축년도</span>
							                            <span class="detail-value">${apt.buildYear}년</span>
							                        </div>
							                    </div>
							                </div>
							            </c:forEach>
							        </c:otherwise>
							    </c:choose>
							</div>
			            </div>
			            
			            <div class="search-result-container">
			                <div class="search-result-header">
			                    <h1 class="search-result-title">
			                        <i class="fas fa-subway"></i>검색 결과
			                    </h1>

			                    <form class="search-form" id="search-form">
			                        <!-- 필터 옵션 -->
			                        <div class="search-filters">
			                            <div class="search-filter">
			                                <label class="filter-label" for="majorRegion">지역</label>
			                                <select class="filter-select" id="majorRegion" name="majorRegion">
			                                    <option value="">선택하세요</option>
			                                    <option value="서울" ${param.majorRegion=='서울' ? 'selected' : '' }>서울특별시</option>
			                                    <option value="부산" ${param.majorRegion=='부산' ? 'selected' : '' }>부산광역시</option>
			                                    <option value="대구" ${param.majorRegion=='대구' ? 'selected' : '' }>대구광역시</option>
			                                    <option value="인천" ${param.majorRegion=='인천' ? 'selected' : '' }>인천광역시</option>
			                                    <option value="광주" ${param.majorRegion=='광주' ? 'selected' : '' }>광주광역시</option>
			                                    <option value="대전" ${param.majorRegion=='대전' ? 'selected' : '' }>대전광역시</option>
			                                    <option value="울산" ${param.majorRegion=='울산' ? 'selected' : '' }>울산광역시</option>
			                                    <option value="경기" ${param.majorRegion=='경기' ? 'selected' : '' }>경기도</option>
			                                </select>
			                            </div>

			                            <div class="search-filter">
			                                <label class="filter-label" for="district">구/군</label>
			                                <select class="filter-select" id="district" name="district">
			                                    <option value="">구/군 선택</option>
			                                    <!-- 대분류에 따라 동적으로 변경됩니다 -->
			                                </select>
			                            </div>

			                            <div class="search-filter">
			                                <label class="filter-label" for="station">지하철역</label>
			                                <select class="filter-select" id="station" name="station">
			                                    <option value="">지하철역 선택</option>
			                                    <!-- 구/군에 따라 동적으로 변경됩니다 -->
			                                </select>
			                            </div>

			                            <div class="search-button-container">
			                                <button type="button" class="search-icon-button" onclick="fn_submit()">
			                                    <i class="fas fa-search"></i>
			                                </button>
			                            </div>
			                        </div>
			                    </form>
			                </div>

			                <div class="map-container">
			                    <div id="map"></div>
			                    <div class="map-loading" id="mapLoading">
			                        <p style="text-align: center; color: var(--gray-500);">
			                            <i class="fas fa-spinner fa-spin" style="margin-right: 8px;"></i> 지도를 불러오는 중입니다...
			                        </p>
			                    </div>
			                </div>
			            </div>
			            
			            <div class="apartment-list-container">
			                <div class="apartment-list-header">
			                    <i class="fas fa-building"></i>
			                    주변 아파트 목록
			                </div>
			                <div class="apartment-list" id="apartmentList">
			                    <!-- 아파트 목록이 여기에 표시됩니다 -->
			                    <p style="text-align: center; padding: 50px 0; color: var(--gray-500);" id="noResultsMessage">
			                        검색 결과가 없습니다. <br> 지하철역을 검색해보세요.
			                    </p>
			                </div>
			            </div>
			        </div>
			    </div>
            <script>
				// 아파트 카드 클릭 시 비교 정보 표시
				document.addEventListener('DOMContentLoaded', function() {
				    // 아파트 데이터가 로드된 후에 이벤트 리스너를 추가하기 위한 MutationObserver 설정
				    const apartmentListContainer = document.getElementById('apartmentList');
				    
				    // MutationObserver 설정
				    const observer = new MutationObserver(function(mutations) {
				        mutations.forEach(function(mutation) {
				            if (mutation.type === 'childList' && mutation.addedNodes.length > 0) {
				                // 새로운 아파트 카드가 추가되면 이벤트 리스너 추가
				                attachEventListenersToCards();
				            }
				        });
				    });
				    
				    // 관찰 시작
				    observer.observe(apartmentListContainer, { childList: true, subtree: true });
				    
				    // 초기 카드에 이벤트 리스너 추가
				    attachEventListenersToCards();

				});

				// 아파트 카드에 이벤트 리스너 추가하는 함수
				function attachEventListenersToCards() {
				    const apartmentCards = document.querySelectorAll('.apartment-card:not(.comparison-item)');
				    console.log('아파트 카드 개수:', apartmentCards.length);
				    
				    apartmentCards.forEach(card => {
				        // 이미 이벤트 리스너가 추가되었는지 확인
				        if (card.dataset.hasClickListener === 'true') {
				            return;
				        }
				        
				        // 데이터 속성 확인
				        console.log('카드 데이터 속성:', {
				            floor: card.dataset.floor,
				            buildYear: card.dataset.buildYear
				        });
				        
				        card.dataset.hasClickListener = 'true';
				        card.addEventListener('click', function() {
				            console.log('아파트 카드 클릭됨');
				            
				            // 카드에서 아파트 정보 추출
				            const aptName = this.querySelector('.apartment-name').textContent;
				            const aptLocation = this.querySelector('.apartment-location').textContent;
				            const aptPrice = this.querySelector('.apartment-price').textContent;
				            const aptSize = this.querySelector('.apartment-details span:first-child').textContent;
				            
				            // 추가 정보 (데이터 속성에서 가져오거나 기본값 사용)
				            const aptFloor = this.dataset.floor || '정보 없음';
				            const aptBuildYear = this.dataset.buildYear || '정보 없음';
				            
				            console.log('추출된 정보:', {
				                aptName, aptLocation, aptPrice, aptSize, aptFloor, aptBuildYear
				            });
				            
				            // 선택된 아파트 정보 표시
				            const selectedApartment = document.getElementById('selectedApartment');
				            if (!selectedApartment) {
				                console.error('selectedApartment 요소를 찾을 수 없습니다');
				                return;
				            }
				            
				            // 선택된 아파트 정보 HTML 생성
				            const html = `
				                <div class="selected-apt-header">
				                    <h3 class="selected-apt-name">${aptName}</h3>
				                    <span class="selected-apt-label">선택됨</span>
				                </div>
				                <div class="selected-apt-location">${aptLocation}</div>
				                <div class="selected-apt-details">
				                    <div class="selected-detail">
				                        <span class="detail-label">가격</span>
				                        <span class="detail-value selected-price">${aptPrice}</span>
				                    </div>
				                    <div class="selected-detail">
				                        <span class="detail-label">평수</span>
				                        <span class="detail-value selected-size">${aptSize}</span>
				                    </div>
				                    <div class="selected-detail">
				                        <span class="detail-label">층수</span>
				                        <span class="detail-value selected-floor">${aptFloor}</span>
				                    </div>
				                    <div class="selected-detail">
				                        <span class="detail-label">건축년도</span>
				                        <span class="detail-value selected-year">${aptBuildYear}</span>
				                    </div>
				                </div>
				            `;
				            
				            // HTML 설정
				            selectedApartment.innerHTML = html;
				            console.log('선택된 아파트 정보가 업데이트되었습니다');
				            
				            // 비교 항목 업데이트
				            updateComparison(aptPrice, aptSize, aptFloor, aptBuildYear);
				        });
				    });
				}

				// 비교 정보 업데이트 함수
				function updateComparison(selectedPrice, selectedSize, selectedFloor, selectedBuildYear) {
				    console.log('비교 업데이트:', { selectedPrice, selectedSize, selectedFloor, selectedBuildYear });
				    
				    const comparisonItems = document.querySelectorAll('.comparison-item');
				    console.log('비교 항목 개수:', comparisonItems.length);
				    
				    if (comparisonItems.length === 0) {
				        console.log('비교할 아파트가 없습니다.');
				        return;
				    }
				    
				    // 가격, 평수, 층수, 건축년도 비교
				    comparisonItems.forEach(item => {
				        try {
				            // 가격 비교
				            const priceElement = item.querySelector('.comparison-detail:nth-child(1) .detail-value');
				            if (priceElement) {
				                const itemPrice = priceElement.textContent;
				                compareValues(priceElement, itemPrice, selectedPrice, true); // 가격은 높을수록 불리
				            }
				            
				            // 평수 비교
				            const sizeElement = item.querySelector('.comparison-detail:nth-child(2) .detail-value');
				            if (sizeElement) {
				                const itemSize = sizeElement.textContent;
				                compareValues(sizeElement, itemSize, selectedSize, false); // 평수는 높을수록 유리
				            }
				            
				            // 층수 비교
				            const floorElement = item.querySelector('.comparison-detail:nth-child(3) .detail-value');
				            if (floorElement) {
				                const itemFloor = floorElement.textContent;
				                compareValues(floorElement, itemFloor, selectedFloor, false); // 층수는 높을수록 유리
				            }
				            
				            // 건축년도 비교
				            const yearElement = item.querySelector('.comparison-detail:nth-child(4) .detail-value');
				            if (yearElement) {
				                const itemYear = yearElement.textContent;
				                compareValues(yearElement, itemYear, selectedBuildYear, false); // 건축년도는 최신일수록 유리
				            }
				        } catch (error) {
				            console.error('비교 중 오류 발생:', error);
				        }
				    });
				}

				// 값 비교 및 스타일 적용 함수
				function compareValues(element, itemValue, selectedValue, isHigherWorse) {
				    console.log('값 비교:', { itemValue, selectedValue, isHigherWorse });
				    
				    // 숫자만 추출
				    const itemNum = extractNumber(itemValue);
				    const selectedNum = extractNumber(selectedValue);
				    
				    console.log('추출된 숫자:', { itemNum, selectedNum });
				    
				    if (itemNum === null || selectedNum === null) {
				        // 숫자 추출 실패 시 비교 불가
				        console.log('숫자 추출 실패');
				        element.classList.remove('better-value', 'worse-value');
				        return;
				    }
				    
				    if (itemNum === selectedNum) {
				        // 값이 같으면 중립
				        console.log('값이 같음');
				        element.classList.remove('better-value', 'worse-value');
				    } else if ((itemNum < selectedNum && isHigherWorse) || (itemNum > selectedNum && !isHigherWorse)) {
				        // 더 좋은 값
				        console.log('더 좋은 값');
				        element.classList.add('better-value');
				        element.classList.remove('worse-value');
				    } else {
				        // 더 나쁜 값
				        console.log('더 나쁜 값');
				        element.classList.add('worse-value');
				        element.classList.remove('better-value');
				    }
				}

				// 문자열에서 숫자만 추출하는 함수
				function extractNumber(str) {
				    if (!str || typeof str !== 'string') {
				        console.log('유효하지 않은 문자열:', str);
				        return null;
				    }
				    
				    const matches = str.match(/[\d,]+/);
				    if (!matches) {
				        console.log('숫자 패턴 없음:', str);
				        return null;
				    }
				    
				    // 쉼표 제거 후 숫자로 변환
				    const result = parseFloat(matches[0].replace(/,/g, ''));
				    console.log('추출된 숫자:', result);
				    return result;
				}

				let map;
				document.addEventListener('DOMContentLoaded', function () {
				    // 현재 열려있는 오버레이를 추적하는 변수
				    let currentOverlay = null;

				    // 검색 파라미터 확인
				    const searchParams = {
				        region: "<c:out value='${searchParams.majorRegion}' default='' />",
				        district: "<c:out value='${searchParams.district}' default='' />",
				        station: "<c:out value='${searchParams.station}' default='' />"
				    };

				    // 지하철역 이름
				    const stationName = searchParams.station;

				    if (!stationName) {
				        console.error("지하철역 정보가 없습니다.");
				        return;
				    }

				    // 카카오맵 초기화
				    const container = document.getElementById('map');
				    const options = {
				        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 서울 시청 (기본값)
				        level: 3 // 지도 확대 레벨
				    };

				    map = new kakao.maps.Map(container, options);

				    // 지도 확대/축소 컨트롤 추가
				    const zoomControl = new kakao.maps.ZoomControl();
				    map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

				    // 지도 로딩 완료 시 로딩 화면 숨기기
				    kakao.maps.event.addListener(map, 'tilesloaded', function () {
				        document.getElementById('mapLoading').style.display = 'none';
				    });

				    // 지도 클릭 시 열려있는 오버레이 닫기
				    kakao.maps.event.addListener(map, 'click', function () {
				        if (currentOverlay) {
				            currentOverlay.setMap(null);
				            currentOverlay = null;
				        }
				    });

				    // 장소 검색 객체 생성
				    const ps = new kakao.maps.services.Places();

				    // 지하철역 검색
				    ps.keywordSearch(stationName, function (data, status) {
				        if (status === kakao.maps.services.Status.OK) {
				            // 검색된 장소 중 지하철역 찾기
				            let stationPlace = null;

				            for (let i = 0; i < data.length; i++) {
				                if (data[i].category_name.includes('교통,수송 > 지하철,전철 > 지하철역')) {
				                    stationPlace = data[i];
				                    break;
				                }
				            }


				            if (!stationPlace && data.length > 0) {
				                // 지하철역 카테고리가 없으면 첫 번째 결과 사용
				                stationPlace = data[0];
				            }

				            if (stationPlace) {
				                // 지하철역 위치로 지도 중심 이동
				                const stationPosition = new kakao.maps.LatLng(stationPlace.y, stationPlace.x);
				                map.setCenter(stationPosition);

				                // 시군구 코드 가져오기
				                const geocoder = new kakao.maps.services.Geocoder();

				                function getAddressInfo(lat, lng) { // lat 위도, lng 경도
				                    geocoder.coord2RegionCode(lng, lat, function(result, status) { // 비동기 처리를 위한 콜백 함수
				                        if (status === kakao.maps.services.Status.OK) { // api 호출 성공 여부
				                            const region = result.find(item => item.region_type === 'H');
				                            if (region) {
				                                const sigunguCode = region.code.substring(0, 5);
				                                console.log('시군구 코드:', sigunguCode);
				                                getApartmentData(sigunguCode);
				                            }
				                        }
				                    });
				                }

				                // 초기 위치의 시군구 코드 가져오기
				                getAddressInfo(stationPlace.y, stationPlace.x);

				                // 지도 클릭 이벤트에서도 시군구 코드 확인
				                kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
				                    const latlng = mouseEvent.latLng;
				                    getAddressInfo(latlng.getLat(), latlng.getLng());
				                });

				                // 기본 마커 대신 지하철역 커스텀 마커 생성 (크기 증가)
				                const stationMarker = new kakao.maps.CustomOverlay({
				                    position: stationPosition,
				                    content: '<div style="' +
				                        'padding: 15px;' +
				                        'background-color: #51bdbd;' +
				                        'color: white;' +
				                        'border-radius: 50%;' +
				                        'font-size: 24px;' +
				                        'font-weight: bold;' +
				                        'box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);' +
				                        'display: flex;' +
				                        'align-items: center;' +
				                        'justify-content: center;' +
				                        'width: 60px;' +
				                        'height: 60px;' +
				                        'transform: translate(-50%, -50%);' +
				                        '">' +
				                        '<i class="fas fa-subway"></i>' +
				                        '</div>',
				                    map: map,
				                    zIndex: 3 // 다른 마커보다 앞에 표시
				                });

				                // 지하철역 정보 오버레이 생성 (위치 조정)
				                const stationInfoOverlay = new kakao.maps.CustomOverlay({
				                    position: stationPosition,
				                    content: '<div class="custom-overlay" style="' +
				                        'position: relative;' +
				                        'bottom: 95px;' +
				                        'border-radius: 6px;' +
				                        'float: left;' +
				                        'background: #fff;' +
				                        'padding: 10px;' +
				                        'box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);' +
				                        'transform: translateX(-50%);' +
				                        'white-space: nowrap;' +
				                        '">' +
				                        '<div class="title" style="' +
				                        'display: block;' +
				                        'font-size: 14px;' +
				                        'font-weight: 600;' +
				                        'color: #51bdbd;' +
				                        'text-align: center;' +
				                        '">' + stationName + '</div>' +
				                        '<div style="' +
				                        'content: \'\';' +
				                        'position: absolute;' +
				                        'bottom: -8px;' +
				                        'left: 50%;' +
				                        'margin-left: -8px;' +
				                        'width: 0;' +
				                        'height: 0;' +
				                        'border-width: 8px 8px 0 8px;' +
				                        'border-style: solid;' +
				                        'border-color: #fff transparent transparent transparent;' +
				                        '"></div>' +
				                        '</div>',
				                    map: map,
				                    yAnchor: 0.5
				                });
				            } else {
				                console.error("지하철역을 찾을 수 없습니다.");
				                document.getElementById('mapLoading').innerHTML =
				                    '<p style="text-align: center; color: var(--danger);">' +
				                    '<i class="fas fa-exclamation-circle" style="margin-right: 8px;"></i> ' +
				                    '지하철역을 찾을 수 없습니다.' +
				                    '</p>';
				            }
				        } else {
				            console.error("장소 검색 실패:", status);
				            document.getElementById('mapLoading').innerHTML =
				                '<p style="text-align: center; color: var(--danger);">' +
				                '<i class="fas fa-exclamation-circle" style="margin-right: 8px;"></i> ' +
				                '지도를 불러오는 중 오류가 발생했습니다.' +
				                '</p>';
				        }
				    });
				});

				function getApartmentData(sigunguCode) {
				    // 현재 날짜 객체 생성
				    const now = new Date();
				    // yyyyMM 형식으로 변환
				    const yearMonth = now.getFullYear().toString() +
				        String(now.getMonth() + 1).padStart(2, '0');
				    console.log('API 호출 파라미터:', {sigunguCode, yearMonth});

				    $.ajax({
				        url: '/api/apartments/trade',
				        method: 'GET',
				        data: {
				            sigunguCode: sigunguCode,
				            yearMonth: yearMonth
				        },
				        success: function(response) {
				            console.log('API 응답 데이터:', response); // 응답 데이터 로깅
				            displayApartments(response);
				        },
				        error: function(xhr, status, error) {
				            console.error('아파트 데이터 조회 실패:', error);
				            console.error('상태 코드:', xhr.status);
				            console.error('응답 텍스트:', xhr.responseText);
				        }
				    });
				}

				let apartmentMarkers = [];
				let currentOverlay = null;

				function displayApartments(apartments) {
				    // 기존 마커/오버레이 제거
				    apartmentMarkers.forEach(marker => marker.setMap(null));
				    apartmentMarkers = [];

				    const apartmentListContainer = document.getElementById('apartmentList');
				    apartmentListContainer.innerHTML = '';

				    if (!apartments || apartments.length === 0) {
				        apartmentListContainer.innerHTML = `
				        <p style="grid-column: 1 / -1; text-align: center; padding: 50px 0; color: var(--gray-500);" id="noResultsMessage">
				            검색 결과가 없습니다.
				        </p>`;
				        return;
				    }

				    apartments.forEach((apt, idx) => {
				        if (apt.lat && apt.lng) {
				            const position = new kakao.maps.LatLng(parseFloat(apt.lat), parseFloat(apt.lng));

				            // 마커 생성
				            const marker = new kakao.maps.Marker({
				                position: position,
				                map: map,
				                clickable: true
				            });
				            apartmentMarkers.push(marker);

				            // 값 준비
				            const aptName = apt.aptNm || "이름 없음";
				            const excluUseAr = apt.excluUseAr ? apt.excluUseAr + "㎡" : "면적 없음";
				            const dealAmount = apt.dealAmount ? apt.dealAmount.toLocaleString() + "만원" : "가격 없음";
				            const locationContent = apt.estateAgentSggNm || "위치 없음";
				            const addressText = locationContent + " " + aptName;

				            // 필요에 따라 추가 정보 처리
				            const floorText = apt.floor || "-";
				            const buildYearText = apt.buildYear ? apt.buildYear + "년" : "-";
				            const roomsText = apt.rooms || "-";
				            const bathroomsText = apt.bathrooms || "-";
				            const maintenanceFeeText = apt.maintenanceFee ? "월 " + apt.maintenanceFee + "만원" : "-";
				            const distanceText = apt.subwayDistance ? apt.subwayStation + "에서 " + apt.subwayDistance + "m" : "-";

				            // 커스텀 오버레이용 HTML 템플릿 (기존 코드 유지)
				            const overlayContent = `
				                <div class="custom-overlay apartment-overlay">
				                    <div class="overlay-header">
				                        <div class="title">`+aptName+`</div>
				                        <button class="close" onclick="this.parentElement.parentElement.parentElement.style.display='none'; if(window.currentOverlay){window.currentOverlay.setMap(null);window.currentOverlay=null;}"></button>
				                    </div>
				                    <div class="overlay-body">
				                        <div class="overlay-section">
				                            <div class="overlay-price">`+dealAmount+`</div>
				                            <div class="overlay-size">`+excluUseAr+`</div>
				                        </div>
				                        <div class="overlay-section">
				                            <div class="overlay-address">`+addressText+`</div>
				                            <div class="overlay-distance">`+distanceText+`</div>
				                        </div>
				                        <div class="overlay-section overlay-details">
				                            <div class="detail-item"><span>방/욕실:</span> `+roomsText+`/`+bathroomsText+`</div>
				                            <div class="detail-item"><span>층수:</span> `+floorText+`</div>
				                            <div class="detail-item"><span>건축년도:</span> `+buildYearText+`</div>
				                            <div class="detail-item"><span>관리비:</span> `+maintenanceFeeText+`</div>
				                        </div>
				                    </div>
				                    <div class="overlay-footer">
				                        <button class="overlay-button favorite" style="width: 100%;">관심 등록</button>
				                    </div>
				                </div>
				            `;
				            // 커스텀 오버레이 생성 (초기에는 지도에 표시하지 않음)
				            const apartmentOverlay = new kakao.maps.CustomOverlay({
				                position: position,
				                content: overlayContent,
				                map: null,
				                yAnchor: 1
				            });
				            apartmentOverlay.apartmentId = apt.id;

				            // 마커 클릭 시 오버레이 열기 (기존 코드 유지)
				            kakao.maps.event.addListener(marker, 'click', function () {
				                // 이미 열려있는 오버레이가 같은 아파트라면 닫기
				                if (currentOverlay && currentOverlay.apartmentId === apt.id) {
				                    currentOverlay.setMap(null);
				                    currentOverlay = null;
				                    return;
				                }
				                // 다른 오버레이가 열려있으면 닫기
				                if (currentOverlay) {
				                    currentOverlay.setMap(null);
				                }
				                apartmentOverlay.setMap(map);
				                currentOverlay = apartmentOverlay;
				            });

				            // 아파트 카드 생성 (기존 코드 유지)
				            const apartmentCard = document.createElement('div');
				            apartmentCard.className = 'apartment-card';
				            
				            // 중요: 데이터 속성 추가 - 이 부분이 누락되어 있었습니다
				            apartmentCard.dataset.floor = floorText;
				            apartmentCard.dataset.buildYear = buildYearText;
				            
				            apartmentCard.innerHTML = `
				                <div class="apartment-image">
				                    <i class="fas fa-building"></i>
				                </div>
				                <div class="apartment-info">
				                    <h3 class="apartment-name">${aptName}</h3>
				                    <div class="apartment-location">${locationContent}</div>
				                    <div class="apartment-details">
				                        <span>${excluUseAr}</span>
				                        <span class="apartment-price">${dealAmount}</span>
				                    </div>
				                </div>
				            `;
				            
				            // 기존 코드 유지
				            const nameH3 = apartmentCard.querySelector('.apartment-name');
				            nameH3.textContent = aptName;
				            const bonbun3 = apartmentCard.querySelector('.apartment-location');
				            bonbun3.textContent = locationContent;
				            const excluUseArSpan = apartmentCard.querySelector('.apartment-details span:nth-child(1)');
				            excluUseArSpan.textContent = excluUseAr;
				            const dealAmountSpan = apartmentCard.querySelector('.apartment-price');
				            dealAmountSpan.textContent = dealAmount;
				            
				            // displayApartments 함수 내의 아파트 카드 클릭 이벤트 핸들러를 다음과 같이 수정
				            apartmentCard.addEventListener('click', function () {
				                map.setCenter(position);
				                map.setLevel(3);

								if (currentOverlay && currentOverlay.apartmentId === apt.id) {
								        currentOverlay.setMap(null);
								        currentOverlay = null;
								    } else {
								        if (currentOverlay) {
								            currentOverlay.setMap(null);
								        }
								        apartmentOverlay.setMap(map);
								        currentOverlay = apartmentOverlay;
								    }
				            });

				            apartmentListContainer.appendChild(apartmentCard);
				        }
				    });
				    
				    // 중요: 모든 카드가 생성된 후 이벤트 리스너 다시 연결
				    attachEventListenersToCards();
				}
            </script>
        </body>

        </html>