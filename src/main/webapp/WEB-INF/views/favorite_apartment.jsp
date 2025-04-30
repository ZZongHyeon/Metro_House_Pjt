<%@page import="com.boot.dto.UserDTO"%>
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
    <style>
        :root {
            --primary: #3b82f6;
            --primary-dark: #2563eb;
            --primary-light: #93c5fd;
            --primary-lighter: #dbeafe;
            --secondary: #334155;
            --accent: #10b981;
            --accent2: #f97316;
            --accent3: #06b6d4;
            --accent4: #8b5cf6;
            --success: #22c55e;
            --danger: #ef4444;
            --warning: #f59e0b;
            --info: #0ea5e9;
            --light: #f8fafc;
            --dark: #1e293b;
            --gray-50: #f9fafb;
            --gray-100: #f1f5f9;
            --gray-200: #e2e8f0;
            --gray-300: #cbd5e1;
            --gray-400: #94a3b8;
            --gray-500: #64748b;
            --border-radius: 16px;
            --border-radius-sm: 8px;
            --box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05), 0 4px 6px -2px rgba(0, 0, 0, 0.025);
            --box-shadow-hover: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8fafc;
            color: var(--dark);
            line-height: 1.6;
        }

        .container {
            max-width: 1280px;
            margin: 40px auto;
            padding: 0 24px;
        }

        .page-header {
            margin-bottom: 40px;
            position: relative;
        }

        .page-title {
            font-size: 32px;
            font-weight: 800;
            color: var(--dark);
            margin-bottom: 12px;
            letter-spacing: -0.5px;
            display: flex;
            align-items: center;
        }

        .page-title i {
            color: var(--primary);
            margin-right: 16px;
            font-size: 32px;
        }

        .page-subtitle {
            color: var(--gray-500);
            font-size: 17px;
            max-width: 700px;
            line-height: 1.7;
        }

        /* 필터 섹션 */
        .filter-section {
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 24px;
            margin-bottom: 32px;
            border: 1px solid var(--gray-100);
        }

        .filter-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .filter-title {
            font-size: 18px;
            font-weight: 700;
            color: var(--dark);
            display: flex;
            align-items: center;
        }

        .filter-title i {
            margin-right: 10px;
            color: var(--primary);
        }

        .filter-controls {
            display: flex;
            gap: 16px;
        }

        .filter-row {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
        }

        .filter-group {
            flex: 1;
            min-width: 200px;
        }

        .filter-label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: var(--gray-500);
            margin-bottom: 8px;
        }

        .filter-select {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid var(--gray-200);
            border-radius: var(--border-radius-sm);
            font-size: 15px;
            color: var(--dark);
            background-color: white;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%2364748b'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'%3E%3C/path%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 16px center;
            background-size: 16px;
            transition: var(--transition);
        }

        .filter-select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
        }

        .filter-input {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid var(--gray-200);
            border-radius: var(--border-radius-sm);
            font-size: 15px;
            color: var(--dark);
            transition: var(--transition);
        }

        .filter-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
        }

        .filter-button {
            padding: 12px 24px;
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: var(--border-radius-sm);
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .filter-button:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(37, 99, 235, 0.2);
        }

        .filter-button i {
            font-size: 16px;
        }

        .filter-reset {
            padding: 12px 24px;
            background-color: white;
            color: var(--gray-500);
            border: 1px solid var(--gray-300);
            border-radius: var(--border-radius-sm);
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .filter-reset:hover {
            background-color: var(--gray-100);
            color: var(--gray-700);
        }

        /* 아파트 카드 그리드 */
        .apartment-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 24px;
            margin-bottom: 40px;
        }

        .apartment-card {
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            overflow: hidden;
            transition: var(--transition);
            border: 1px solid var(--gray-100);
            height: 100%;
            display: flex;
            flex-direction: column;
            position: relative;
        }

        .apartment-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--box-shadow-hover);
            border-color: var(--primary-light);
        }

        .apartment-image {
            height: 180px;
            background-color: var(--gray-100);
            position: relative;
            overflow: hidden;
        }

        .apartment-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: var(--transition);
        }

        .apartment-card:hover .apartment-image img {
            transform: scale(1.05);
        }

        .apartment-favorite {
            position: absolute;
            top: 16px;
            right: 16px;
            width: 40px;
            height: 40px;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            z-index: 2;
        }

        .apartment-favorite i {
            color: var(--danger);
            font-size: 18px;
            transition: var(--transition);
        }

        .apartment-favorite:hover {
            background-color: var(--danger);
            transform: scale(1.1);
        }

        .apartment-favorite:hover i {
            color: white;
        }

        .apartment-badge {
            position: absolute;
            top: 16px;
            left: 16px;
            padding: 6px 12px;
            background-color: var(--primary);
            color: white;
            font-size: 12px;
            font-weight: 600;
            border-radius: 20px;
            z-index: 2;
        }

        .apartment-content {
            padding: 24px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .apartment-title {
            font-size: 18px;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 8px;
            line-height: 1.4;
        }

        .apartment-location {
            display: flex;
            align-items: center;
            color: var(--gray-500);
            font-size: 14px;
            margin-bottom: 16px;
        }

        .apartment-location i {
            margin-right: 8px;
            color: var(--primary);
            font-size: 14px;
        }

        .apartment-details {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
            margin-bottom: 20px;
        }

        .detail-item {
            display: flex;
            flex-direction: column;
        }

        .detail-label {
            font-size: 12px;
            color: var(--gray-500);
            margin-bottom: 4px;
        }

        .detail-value {
            font-size: 15px;
            font-weight: 600;
            color: var(--dark);
        }

        .apartment-price {
            margin-top: auto;
            padding-top: 16px;
            border-top: 1px solid var(--gray-200);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .price-value {
            font-size: 20px;
            font-weight: 800;
            color: var(--primary);
        }

        .price-unit {
            font-size: 14px;
            color: var(--gray-500);
            font-weight: 400;
        }

        .apartment-button {
            padding: 8px 16px;
            background-color: var(--primary-lighter);
            color: var(--primary);
            border: none;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .apartment-button:hover {
            background-color: var(--primary);
            color: white;
        }

        /* 페이지네이션 */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 40px;
            gap: 8px;
        }

        .page-item {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .page-link {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background-color: white;
            color: var(--gray-500);
            font-weight: 600;
            transition: var(--transition);
            text-decoration: none;
            border: 1px solid var(--gray-200);
        }

        .page-link:hover {
            background-color: var(--primary-lighter);
            color: var(--primary);
            border-color: var(--primary-light);
        }

        .page-item.active .page-link {
            background-color: var(--primary);
            color: white;
            border-color: var(--primary);
        }

        .page-item.disabled .page-link {
            opacity: 0.5;
            cursor: not-allowed;
        }

        /* 빈 상태 */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            margin-bottom: 40px;
        }

        .empty-icon {
            width: 120px;
            height: 120px;
            background-color: var(--primary-lighter);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 32px;
        }

        .empty-icon i {
            font-size: 48px;
            color: var(--primary);
        }

        .empty-title {
            font-size: 24px;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 16px;
        }

        .empty-description {
            font-size: 16px;
            color: var(--gray-500);
            max-width: 500px;
            margin: 0 auto 32px;
            line-height: 1.7;
        }

        .empty-button {
            padding: 14px 28px;
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: 30px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
        }

        .empty-button:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.2);
        }

        /* 반응형 디자인 */
        @media (max-width: 992px) {
            .apartment-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .container {
                padding: 0 16px;
                margin: 24px auto;
            }

            .page-title {
                font-size: 28px;
            }

            .page-subtitle {
                font-size: 16px;
            }

            .filter-row {
                flex-direction: column;
            }

            .filter-controls {
                flex-direction: column;
                width: 100%;
            }

            .filter-button, .filter-reset {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 576px) {
            .apartment-grid {
                grid-template-columns: 1fr;
            }

            .apartment-details {
                grid-template-columns: 1fr;
            }
        }

        /* 애니메이션 */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .apartment-card {
            animation: fadeIn 0.5s ease-out;
            animation-fill-mode: both;
        }

        .apartment-card:nth-child(1) { animation-delay: 0.1s; }
        .apartment-card:nth-child(2) { animation-delay: 0.2s; }
        .apartment-card:nth-child(3) { animation-delay: 0.3s; }
        .apartment-card:nth-child(4) { animation-delay: 0.4s; }
        .apartment-card:nth-child(5) { animation-delay: 0.5s; }
        .apartment-card:nth-child(6) { animation-delay: 0.6s; }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container">
        <div class="page-header">
            <h1 class="page-title"><i class="fas fa-heart"></i> 관심 아파트</h1>
            <p class="page-subtitle">회원님이 관심 등록한 아파트 목록입니다. 가격 변동 및 상세 정보를 확인하고 비교해보세요.</p>
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
                    <select class="filter-select">
                        <option value="">전체</option>
                        <option value="서울">서울특별시</option>
                        <option value="경기">경기도</option>
                        <option value="인천">인천광역시</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label class="filter-label">구/군</label>
                    <select class="filter-select">
                        <option value="">전체</option>
                        <option value="강남구">강남구</option>
                        <option value="서초구">서초구</option>
                        <option value="송파구">송파구</option>
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
        int favoriteCount = 0;
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
            <c:forEach var="apartment" items="${favoriteApartments}" varStatus="status">
                <div class="apartment-card">
                    <div class="apartment-image">
                        <img src="/resources/images/apartments/${apartment.apartmentId}.jpg" 
                             onerror="this.src='/resources/images/apartment-placeholder.jpg'" 
                             alt="${apartment.apartmentName}">
                        <div class="apartment-favorite" onclick="removeFavorite(${apartment.apartmentId})">
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
        </div>

        <div class="pagination">
            <div class="page-item disabled">
                <a class="page-link" href="#" aria-label="Previous">
                    <i class="fas fa-chevron-left"></i>
                </a>
            </div>
            <div class="page-item active">
                <a class="page-link" href="#">1</a>
            </div>
            <div class="page-item">
                <a class="page-link" href="#">2</a>
            </div>
            <div class="page-item">
                <a class="page-link" href="#">3</a>
            </div>
            <div class="page-item">
                <a class="page-link" href="#" aria-label="Next">
                    <i class="fas fa-chevron-right"></i>
                </a>
            </div>
        </div>
        <% } else { %>
        <div class="empty-state">
            <div class="empty-icon">
                <i class="fas fa-heart"></i>
            </div>
            <h2 class="empty-title">관심 등록된 아파트가 없습니다</h2>
            <p class="empty-description">
                관심있는 아파트를 등록하면 이곳에서 한눈에 확인하고 가격 변동 알림을 받을 수 있습니다.
                지금 아파트를 검색하고 관심 목록에 추가해보세요!
            </p>
            <a href="/apartment_search_view" class="empty-button">
                <i class="fas fa-search"></i> 아파트 검색하기
            </a>
        </div>
        <% } %>
    </div>

    <script>
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
        });
        
        // 필터 검색 버튼
        document.querySelector('.filter-button').addEventListener('click', function() {
            // 실제 구현 시 필터 값을 가져와서 서버로 요청을 보내는 코드 작성
            alert('필터 검색 기능은 현재 개발 중입니다.');
        });
    </script>
</body>
</html>