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
            <link rel="stylesheet" type="text/css" href="/resources/css/main.css">
            <link rel="stylesheet" type="text/css" href="/resources/css/search_map.css">
            <script src="/resources/js/subway_section.js"></script>
            <script src="/resources/js/main.js"></script>
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        </head>

        <body>
            <jsp:include page="header.jsp" />

            <div class="container">
                <div class="search-result-container">
                    <div class="search-result-header">
                        <h1 class="search-result-title">
                            <i class="fas fa-subway"></i> 지하철역 주변 아파트 검색 결과
                        </h1>
                        <!-- <a href="/" class="btn-sm">
                    <i class="fas fa-search"></i>
                </a> -->


                        <form class="search-form" id="search-form">
                            <!-- 필터 옵션 -->
                            <div class="search-filters">
                                <div class="search-filter">
                                    <label class="filter-label" for="majorRegion">지역</label>
                                    <select class="filter-select" id="majorRegion" name="majorRegion">
                                        <option value="">선택하세요</option>
                                        <option value="서울" ${param.majorRegion=='서울' ? 'selected' : '' }>서울특별시
                                        </option>
                                        <option value="부산" ${param.majorRegion=='부산' ? 'selected' : '' }>부산광역시
                                        </option>
                                        <option value="대구" ${param.majorRegion=='대구' ? 'selected' : '' }>대구광역시
                                        </option>
                                        <option value="인천" ${param.majorRegion=='인천' ? 'selected' : '' }>인천광역시
                                        </option>
                                        <option value="광주" ${param.majorRegion=='광주' ? 'selected' : '' }>광주광역시
                                        </option>
                                        <option value="대전" ${param.majorRegion=='대전' ? 'selected' : '' }>대전광역시
                                        </option>
                                        <option value="울산" ${param.majorRegion=='울산' ? 'selected' : '' }>울산광역시
                                        </option>
                                        <option value="경기" ${param.majorRegion=='경기' ? 'selected' : '' }>경기도
                                        </option>
                                        <!-- 다른 지역 옵션은 주석 처리됨 -->
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

                    <div class="search-info">
                        <p><strong>검색 지역 :</strong> ${searchParams.majorRegion}</p>
                        <p><strong>구/군 :</strong> ${searchParams.district}</p>
                        <p><strong>지하철역 :</strong> ${searchParams.station}</p>
                    </div>

                    <div class="map-container">
                        <div id="map"></div>
                        <div class="map-loading" id="mapLoading">
                            <p style="text-align: center; color: var(--gray-500);">
                                <i class="fas fa-spinner fa-spin" style="margin-right: 8px;"></i> 지도를 불러오는 중입니다...
                            </p>
                        </div>
                    </div>

                    <h2 style="margin-bottom: 20px; font-size: 18px;">
                        <i class="fas fa-building" style="color: var(--primary); margin-right: 8px;"></i>
                        주변 아파트 목록
                    </h2>

                    <div class="apartment-list" id="apartmentList">
                        <!-- 아파트 목록이 여기에 표시됩니다 -->
                        <p style="grid-column: 1 / -1; text-align: center; padding: 50px 0; color: var(--gray-500);"
                            id="noResultsMessage">
                            검색 결과가 없습니다. 다른 지하철역을 검색해보세요.
                        </p>
                    </div>
                </div>
            </div>

            <!-- 카카오맵 API 스크립트 -->
            <script type="text/javascript"
                src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoApiKey}&libraries=services"></script>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    // 검색 파라미터 확인
                    const searchParams = {
                        region: "${searchParams.majorRegion}",
                        district: "${searchParams.district}",
                        station: "${searchParams.station}"
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

                    const map = new kakao.maps.Map(container, options);

                    // 지도 로딩 완료 시 로딩 화면 숨기기
                    kakao.maps.event.addListener(map, 'tilesloaded', function () {
                        document.getElementById('mapLoading').style.display = 'none';
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

                                // 기본 마커 대신 지하철역 커스텀 마커 생성 (크기 증가)
                                const stationMarker = new kakao.maps.CustomOverlay({
                                    position: stationPosition,
                                    content: `
            <div style="
                padding: 15px;
                background-color: #51bdbd;
                color: white;
                border-radius: 50%;
                font-size: 24px;
                font-weight: bold;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
                display: flex;
                align-items: center;
                justify-content: center;
                width: 60px;
                height: 60px;
                transform: translate(-50%, -50%);
            ">
                <i class="fas fa-subway"></i>
            </div>
        `,
                                    map: map,
                                    zIndex: 3 // 다른 마커보다 앞에 표시
                                });

                                // 지하철역 정보 오버레이 생성 (위치 조정)
                                const stationInfoOverlay = new kakao.maps.CustomOverlay({
                                    position: stationPosition,
                                    content: `
            <div class="custom-overlay" style="
                position: relative;
                bottom: 100px;
                border-radius: 6px;
                float: left;
                background: #fff;
                padding: 10px;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
                transform: translateX(-50%);
                white-space: nowrap;
            ">
                <div class="title" style="
                    display: block;
                    font-size: 14px;
                    font-weight: 600;
                    color: #51bdbd;
                    text-align: center;
                ">${stationName}</div>
                <div style="
                    content: '';
                    position: absolute;
                    bottom: -8px;
                    left: 50%;
                    margin-left: -8px;
                    width: 0;
                    height: 0;
                    border-width: 8px 8px 0 8px;
                    border-style: solid;
                    border-color: #fff transparent transparent transparent;
                "></div>
            </div>
        `,
                                    map: map,
                                    yAnchor: 0.5
                                });

                                // 주변 아파트 데이터 실제 값 넣어야함
                                const apartments = [];

                                // 아파트 마커 생성 및 목록 표시
                                if (apartments.length > 0) {
                                    // 결과 없음 메시지 숨기기
                                    document.getElementById('noResultsMessage').style.display = 'none';

                                    // 아파트 목록 컨테이너
                                    const apartmentListContainer = document.getElementById('apartmentList');

                                    // 아파트 마커 및 목록 생성
                                    apartments.forEach(apartment => {
                                        // 아파트 마커 생성
                                        const apartmentPosition = new kakao.maps.LatLng(apartment.lat, apartment.lng);
                                        const apartmentMarker = new kakao.maps.Marker({
                                            position: apartmentPosition,
                                            map: map
                                        });

                                        // 아파트 마커 클릭 이벤트
                                        kakao.maps.event.addListener(apartmentMarker, 'click', function () {
                                            // 아파트 정보 오버레이 생성
                                            const apartmentOverlay = new kakao.maps.CustomOverlay({
                                                position: apartmentPosition,
                                                content: `
                                            <div class="custom-overlay">
                                                <div class="title">${apartment.name}</div>
                                                <div>${apartment.price}만원 / ${apartment.size}㎡</div>
                                                <div>${apartment.distance} 거리</div>
                                                <button class="close" onclick="this.parentElement.parentElement.style.display='none'"></button>
                                            </div>
                                        `,
                                                map: map,
                                                yAnchor: 1
                                            });
                                        });

                                        // 아파트 카드 생성
                                        const apartmentCard = document.createElement('div');
                                        apartmentCard.className = 'apartment-card';
                                        apartmentCard.innerHTML = `
                                    <div class="apartment-image">
                                        <i class="fas fa-building"></i>
                                    </div>
                                    <div class="apartment-info">
                                        <h3 class="apartment-name">${apartment.name}</h3>
                                        <div class="apartment-location">${apartment.location} (${apartment.distance})</div>
                                        <div class="apartment-details">
                                            <span>${apartment.size}㎡</span>
                                            <span class="apartment-price">${apartment.price.toLocaleString()}만원</span>
                                        </div>
                                    </div>
                                `;

                                        // 아파트 카드 클릭 이벤트
                                        apartmentCard.addEventListener('click', function () {
                                            // 해당 아파트 위치로 지도 이동
                                            map.setCenter(apartmentPosition);
                                            map.setLevel(3); // 확대

                                            // 아파트 정보 오버레이 생성
                                            const apartmentOverlay = new kakao.maps.CustomOverlay({
                                                position: apartmentPosition,
                                                content: `
                                            <div class="custom-overlay">
                                                <div class="title">${apartment.name}</div>
                                                <div>${apartment.price}만원 / ${apartment.size}㎡</div>
                                                <div>${apartment.distance} 거리</div>
                                                <button class="close" onclick="this.parentElement.parentElement.style.display='none'"></button>
                                            </div>
                                        `,
                                                map: map,
                                                yAnchor: 1
                                            });
                                        });

                                        // 아파트 카드를 목록에 추가
                                        apartmentListContainer.appendChild(apartmentCard);
                                    });
                                }
                            } else {
                                console.error("지하철역을 찾을 수 없습니다.");
                                document.getElementById('mapLoading').innerHTML = `
                            <p style="text-align: center; color: var(--danger);">
                                <i class="fas fa-exclamation-circle" style="margin-right: 8px;"></i> 
                                지하철역을 찾을 수 없습니다.
                            </p>
                        `;
                            }
                        } else {
                            console.error("장소 검색 실패:", status);
                            document.getElementById('mapLoading').innerHTML = `
                        <p style="text-align: center; color: var(--danger);">
                            <i class="fas fa-exclamation-circle" style="margin-right: 8px;"></i> 
                            지도를 불러오는 중 오류가 발생했습니다.
                        </p>
                    `;
                        }
                    });
                });
            </script>
        </body>

        </html>