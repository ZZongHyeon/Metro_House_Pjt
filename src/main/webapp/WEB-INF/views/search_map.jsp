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
                
                        const map = new kakao.maps.Map(container, options);
                
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
                
                                    // 주변 아파트 데이터 (예시 데이터)
                                    // 실제로는 서버에서 데이터를 가져와야 합니다
                                    const apartments = [
                                        {
                                            id: 1,
                                            name: "래미안 아파트",
                                            location: "강남구 역삼동",
                                            address: "서울특별시 강남구 역삼동 123-45",
                                            distance: "350m",
                                            price: 120000,
                                            size: 84.5,
                                            rooms: "3",
                                            bathrooms: "2",
                                            floor: "12/15",
                                            buildYear: 2015,
                                            households: 248,
                                            parkingRatio: "1.2대/세대",
                                            heatingType: "지역난방",
                                            maintenanceFee: 25,
                                            schools: "역삼초(도보 5분), 역삼중(도보 10분)",
                                            amenities: "편의점, 카페, 마트, 공원",
                                            transport: "2호선 역삼역(5분), 146번 버스(3분)",
                                            lat: parseFloat(stationPlace.y) + 0.002,
                                            lng: parseFloat(stationPlace.x) + 0.001
                                        },
                                        {
                                            id: 2,
                                            name: "힐스테이트",
                                            location: "강남구 역삼동",
                                            address: "서울특별시 강남구 역삼동 456-78",
                                            distance: "450m",
                                            price: 115000,
                                            size: 76.8,
                                            rooms: "2",
                                            bathrooms: "1",
                                            floor: "8/20",
                                            buildYear: 2018,
                                            households: 320,
                                            parkingRatio: "1.5대/세대",
                                            heatingType: "개별난방",
                                            maintenanceFee: 22,
                                            schools: "역삼초(도보 8분), 역삼중(도보 15분)",
                                            amenities: "편의점, 헬스장, 어린이집, 도서관",
                                            transport: "2호선 역삼역(8분), 147번 버스(2분)",
                                            lat: parseFloat(stationPlace.y) - 0.001,
                                            lng: parseFloat(stationPlace.x) + 0.002
                                        },
                                        {
                                            id: 3,
                                            name: "푸르지오",
                                            location: "강남구 역삼동",
                                            address: "서울특별시 강남구 역삼동 789-10",
                                            distance: "500m",
                                            price: 95000,
                                            size: 59.8,
                                            rooms: "2",
                                            bathrooms: "1",
                                            floor: "5/15",
                                            buildYear: 2010,
                                            households: 180,
                                            parkingRatio: "1.0대/세대",
                                            heatingType: "중앙난방",
                                            maintenanceFee: 18,
                                            schools: "역삼초(도보 10분), 역삼중(도보 20분)",
                                            amenities: "편의점, 은행, 약국, 놀이터",
                                            transport: "2호선 역삼역(10분), 148번 버스(5분)",
                                            lat: parseFloat(stationPlace.y) + 0.001,
                                            lng: parseFloat(stationPlace.x) - 0.002
                                        }
                                    ];
                
                                    // 아파트 마커 생성 및 목록 표시
                                    if (apartments.length > 0) {
                                        // 결과 없음 메시지 숨기기
                                        document.getElementById('noResultsMessage').style.display = 'none';
                
                                        // 아파트 목록 컨테이너
                                        const apartmentListContainer = document.getElementById('apartmentList');
                                        apartmentListContainer.innerHTML = ''; // 기존 내용 삭제
                
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
                                                // 이미 열려있는 오버레이가 있고, 같은 마커의 오버레이라면 닫기
                                                if (currentOverlay && currentOverlay.apartmentId === apartment.id) {
                                                    currentOverlay.setMap(null);
                                                    currentOverlay = null;
                                                    return;
                                                }
                
                                                // 이미 열려있는 다른 오버레이가 있다면 닫기
                                                if (currentOverlay) {
                                                    currentOverlay.setMap(null);
                                                }
                
                                                // 값 확인 함수
                                                function checkValue(value, defaultValue) {
                                                    return (value !== undefined && value !== null) ? value : defaultValue;
                                                }
                
                                                // 아파트 이름
                                                const aptName = checkValue(apartment.name, '정보 없음');
                                                
                                                // 아파트 가격
                                                let priceText = '가격 정보 없음';
                                                if (apartment.price !== undefined && apartment.price !== null) {
                                                    priceText = apartment.price.toLocaleString() + '만원';
                                                }
                                                
                                                // 아파트 크기
                                                let sizeText = '면적 정보 없음';
                                                if (apartment.size !== undefined && apartment.size !== null) {
                                                    sizeText = apartment.size + '㎡ (' + Math.floor(apartment.size * 0.3025) + '평)';
                                                }
                                                
                                                // 아파트 주소
                                                let addressText = '주소 정보 없음';
                                                if (apartment.address !== undefined && apartment.address !== null) {
                                                    addressText = apartment.address;
                                                } else if (apartment.location !== undefined && apartment.location !== null) {
                                                    addressText = apartment.location;
                                                }
                                                
                                                // 지하철역과의 거리
                                                let distanceText = '거리 정보 없음';
                                                if (apartment.distance !== undefined && apartment.distance !== null) {
                                                    distanceText = '지하철역에서 ' + apartment.distance;
                                                }
                                                
                                                // 방/욕실 정보
                                                let roomsText = '-';
                                                if (apartment.rooms !== undefined && apartment.rooms !== null) {
                                                    roomsText = apartment.rooms + '개';
                                                }
                                                
                                                let bathroomsText = '-';
                                                if (apartment.bathrooms !== undefined && apartment.bathrooms !== null) {
                                                    bathroomsText = apartment.bathrooms + '개';
                                                }
                                                
                                                // 층수 정보
                                                let floorText = '-';
                                                if (apartment.floor !== undefined && apartment.floor !== null) {
                                                    floorText = apartment.floor;
                                                }
                                                
                                                // 건축년도 정보
                                                let buildYearText = '-';
                                                if (apartment.buildYear !== undefined && apartment.buildYear !== null) {
                                                    buildYearText = apartment.buildYear + '년';
                                                }
                                                
                                                // 관리비 정보
                                                let maintenanceFeeText = '-';
                                                if (apartment.maintenanceFee !== undefined && apartment.maintenanceFee !== null) {
                                                    maintenanceFeeText = '월 ' + apartment.maintenanceFee + '만원';
                                                }
                
                                                // 아파트 정보 오버레이 생성
                                                const apartmentOverlay = new kakao.maps.CustomOverlay({
                                                    position: apartmentPosition,
                                                    content: '<div class="custom-overlay apartment-overlay">' +
                                                        '<div class="overlay-header">' +
                                                        '<div class="title">' + aptName + '</div>' +
                                                        '<button class="close" onclick="this.parentElement.parentElement.parentElement.style.display=\'none\'; currentOverlay = null;"></button>' +
                                                        '</div>' +
                                                        '<div class="overlay-body">' +
                                                        '<div class="overlay-section">' +
                                                        '<div class="overlay-price">' + priceText + '</div>' +
                                                        '<div class="overlay-size">' + sizeText + '</div>' +
                                                        '</div>' +
                                                        '<div class="overlay-section">' +
                                                        '<div class="overlay-address">' + addressText + '</div>' +
                                                        '<div class="overlay-distance">' + distanceText + '</div>' +
                                                        '</div>' +
                                                        '<div class="overlay-section overlay-details">' +
                                                        '<div class="detail-item"><span>방/욕실:</span> ' + roomsText + '/' + bathroomsText + '</div>' +
                                                        '<div class="detail-item"><span>층수:</span> ' + floorText + '</div>' +
                                                        '<div class="detail-item"><span>건축년도:</span> ' + buildYearText + '</div>' +
                                                        '<div class="detail-item"><span>관리비:</span> ' + maintenanceFeeText + '</div>' +
                                                        '</div>' +
                                                        '</div>' +
                                                        '<div class="overlay-footer">' +
                                                        '<button class="overlay-button favorite" style="width: 100%;">관심 등록</button>' +
                                                        '</div>' +
                                                        '</div>',
                                                    map: map,
                                                    yAnchor: 1
                                                });
                
                                                // 현재 오버레이에 아파트 ID 저장하여 추적
                                                apartmentOverlay.apartmentId = apartment.id;
                
                                                // 현재 열린 오버레이 업데이트
                                                currentOverlay = apartmentOverlay;
                                            });
                
                                            // 아파트 카드 생성
                                            const apartmentCard = document.createElement('div');
                                            apartmentCard.className = 'apartment-card';
                                            apartmentCard.innerHTML = 
                                                '<div class="apartment-image">' +
                                                '<i class="fas fa-building"></i>' +
                                                '</div>' +
                                                '<div class="apartment-info">' +
                                                '<h3 class="apartment-name">' + apartment.name + '</h3>' +
                                                '<div class="apartment-location">' + apartment.location + ' (' + apartment.distance + ')</div>' +
                                                '<div class="apartment-details">' +
                                                '<span>' + apartment.size + '㎡ (' + Math.floor(apartment.size * 0.3025) + '평)</span>' +
                                                '<span class="apartment-price">' + apartment.price.toLocaleString() + '만원</span>' +
                                                '</div>' +
                                                '<div class="apartment-sub-details">' +
                                                '<span>' + apartment.rooms + '방 ' + apartment.bathrooms + '욕실</span>' +
                                                '<span>' + apartment.buildYear + '년 건축</span>' +
                                                '</div>' +
                                                '</div>';
                
                                            // 아파트 카드 클릭 이벤트
                                            apartmentCard.addEventListener('click', function () {
                                                // 해당 아파트 위치로 지도 이동
                                                map.setCenter(apartmentPosition);
                                                map.setLevel(3); // 확대
                
                                                // 이미 열려있는 오버레이가 있고, 같은 아파트의 오버레이라면 닫기
                                                if (currentOverlay && currentOverlay.apartmentId === apartment.id) {
                                                    currentOverlay.setMap(null);
                                                    currentOverlay = null;
                                                    return;
                                                }
                
                                                // 이미 열려있는 다른 오버레이가 있다면 닫기
                                                if (currentOverlay) {
                                                    currentOverlay.setMap(null);
                                                }
                
                                                // 값 확인 함수
                                                function checkValue(value, defaultValue) {
                                                    return (value !== undefined && value !== null) ? value : defaultValue;
                                                }
                
                                                // 아파트 이름
                                                const aptName = checkValue(apartment.name, '정보 없음');
                                                
                                                // 아파트 가격
                                                let priceText = '가격 정보 없음';
                                                if (apartment.price !== undefined && apartment.price !== null) {
                                                    priceText = apartment.price.toLocaleString() + '만원';
                                                }
                                                
                                                // 아파트 크기
                                                let sizeText = '면적 정보 없음';
                                                if (apartment.size !== undefined && apartment.size !== null) {
                                                    sizeText = apartment.size + '㎡ (' + Math.floor(apartment.size * 0.3025) + '평)';
                                                }
                                                
                                                // 아파트 주소
                                                let addressText = '주소 정보 없음';
                                                if (apartment.address !== undefined && apartment.address !== null) {
                                                    addressText = apartment.address;
                                                } else if (apartment.location !== undefined && apartment.location !== null) {
                                                    addressText = apartment.location;
                                                }
                                                
                                                // 지하철역과의 거리
                                                let distanceText = '거리 정보 없음';
                                                if (apartment.distance !== undefined && apartment.distance !== null) {
                                                    distanceText = '지하철역에서 ' + apartment.distance;
                                                }
                                                
                                                // 방/욕실 정보
                                                let roomsText = '-';
                                                if (apartment.rooms !== undefined && apartment.rooms !== null) {
                                                    roomsText = apartment.rooms + '개';
                                                }
                                                
                                                let bathroomsText = '-';
                                                if (apartment.bathrooms !== undefined && apartment.bathrooms !== null) {
                                                    bathroomsText = apartment.bathrooms + '개';
                                                }
                                                
                                                // 층수 정보
                                                let floorText = '-';
                                                if (apartment.floor !== undefined && apartment.floor !== null) {
                                                    floorText = apartment.floor;
                                                }
                                                
                                                // 건축년도 정보
                                                let buildYearText = '-';
                                                if (apartment.buildYear !== undefined && apartment.buildYear !== null) {
                                                    buildYearText = apartment.buildYear + '년';
                                                }
                                                
                                                // 관리비 정보
                                                let maintenanceFeeText = '-';
                                                if (apartment.maintenanceFee !== undefined && apartment.maintenanceFee !== null) {
                                                    maintenanceFeeText = '월 ' + apartment.maintenanceFee + '만원';
                                                }
                
                                                // 아파트 정보 오버레이 생성
                                                const apartmentOverlay = new kakao.maps.CustomOverlay({
                                                    position: apartmentPosition,
                                                    content: '<div class="custom-overlay apartment-overlay">' +
                                                        '<div class="overlay-header">' +
                                                        '<div class="title">' + aptName + '</div>' +
                                                        '<button class="close" onclick="this.parentElement.parentElement.parentElement.style.display=\'none\'; currentOverlay = null;"></button>' +
                                                        '</div>' +
                                                        '<div class="overlay-body">' +
                                                        '<div class="overlay-section">' +
                                                        '<div class="overlay-price">' + priceText + '</div>' +
                                                        '<div class="overlay-size">' + sizeText + '</div>' +
                                                        '</div>' +
                                                        '<div class="overlay-section">' +
                                                        '<div class="overlay-address">' + addressText + '</div>' +
                                                        '<div class="overlay-distance">' + distanceText + '</div>' +
                                                        '</div>' +
                                                        '<div class="overlay-section overlay-details">' +
                                                        '<div class="detail-item"><span>방/욕실:</span> ' + roomsText + '/' + bathroomsText + '</div>' +
                                                        '<div class="detail-item"><span>층수:</span> ' + floorText + '</div>' +
                                                        '<div class="detail-item"><span>건축년도:</span> ' + buildYearText + '</div>' +
                                                        '<div class="detail-item"><span>관리비:</span> ' + maintenanceFeeText + '</div>' +
                                                        '</div>' +
                                                        '</div>' +
                                                        '<div class="overlay-footer">' +
                                                        '<button class="overlay-button favorite" style="width: 100%;">관심 등록</button>' +
                                                        '</div>' +
                                                        '</div>',
                                                    map: map,
                                                    yAnchor: 1
                                                });
                
                                                // 현재 오버레이에 아파트 ID 저장하여 추적
                                                apartmentOverlay.apartmentId = apartment.id;
                
                                                // 현재 열린 오버레이 업데이트
                                                currentOverlay = apartmentOverlay;
                                            });
                
                                            // 아파트 카드를 목록에 추가
                                            apartmentListContainer.appendChild(apartmentCard);
                                        });
                                    }
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
                </script>
        </body>

        </html>