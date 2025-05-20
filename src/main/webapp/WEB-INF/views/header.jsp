<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메트로하우스 - 지하철역 주변 아파트 시세</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/resources/css/header.css">
    <script>
        window.addEventListener("unload", function() {
            navigator.sendBeacon("/disconnect");
        });
    </script>
</head>
<body>
    <c:set var="currentPage" value="${requestScope['javax.servlet.forward.request_uri']}" />

    <header class="top-header">
        <div class="header-container">
            <!-- 로고 섹션 -->
            <div class="logo-section">
                <a href="/" class="logo-link">
                    <div class="logo-icon">
                        <i class="fa-solid fa-train-subway"></i>
                    </div>
                    <span class="logo-text">메트로하우스</span>
                </a>
            </div>

            <!-- 네비게이션 링크 -->
            <nav class="nav-links" id="navLinks">
                <a href="/" class="nav-link ${currentPage == '/' ? 'active' : ''}">
                    <i class="nav-icon fa-solid fa-house"></i>
                    <span>메인</span>
                </a>
                <a href="/board_view" class="nav-link ${currentPage == '/board_view' ? 'active' : ''}">
                    <i class="nav-icon fa-solid fa-clipboard-list"></i>
                    <span>게시판</span>
                </a>
                <a href="/search_map?majorRegion=서울&district=강남구&station=강남역" class="nav-link ${currentPage == '/search_map' ? 'active' : ''}">
                    <i class="nav-icon fa-solid fa-map-location-dot"></i>
                    <span>지도</span>
                </a>
                <c:if test="${user != null}">
                <a href="/favorite_apartment" class="nav-link ${currentPage == '/favorite_apartment' ? 'active' : ''}">
                    <i class="nav-icon fa-solid fa-heart"></i>
                    <span>관심아파트</span>
                </a>
                </c:if>
            </nav>

            <!-- 사용자 메뉴 -->
            <div class="user-menu">
                <c:choose>
                    <c:when test="${user != null}">
                    <div class="user-dropdown" id="userDropdown">
                        <button class="dropdown-toggle" id="dropdownToggle">
                            <div class="user-avatar">
                                ${fn:substring(user.userName, 0, 1)}
                            </div>
                            <span class="user-name">${user.userName} 님</span>
                            <span class="toggle-icon"><i class="fa-solid fa-chevron-down"></i></span>
                        </button>
                        

                        
                        <!-- 드롭다운 메뉴 -->
                        <div class="dropdown-menu">
                            <!-- 드롭다운 헤더 -->
                            <div class="dropdown-header">
                                <div class="dropdown-header-bg"></div>
                                <div class="dropdown-header-content">
                                    <div class="user-avatar large">
                                        ${fn:substring(user.userName, 0, 1)}
                                    </div>
                                    <div class="header-info">
                                        <div class="header-name">${user.userName} 님</div>
                                        <div class="header-email">${user.userEmail}</div>
                                    </div>
                                </div>
                            </div>

                            <!-- 드롭다운 메뉴 컨테이너 -->
                            <div class="dropdown-menu-container">
                                <!-- 내 계정 섹션 -->
                                <div class="dropdown-section">
                                    <div class="dropdown-section-title">내 계정</div>
                                    <a href="mypage" class="dropdown-item">
                                        <div class="dropdown-icon-wrapper">
                                            <i class="dropdown-icon fa-solid fa-user"></i>
                                        </div>
                                        <div class="dropdown-item-content">
                                            <div class="dropdown-item-title">마이페이지</div>
                                            <div class="dropdown-item-description">계정 정보 및 활동 내역 확인</div>
                                        </div>
                                    </a>
                                </div>

                                <!-- 서비스 섹션 -->
                                <div class="dropdown-section">
                                    <div class="dropdown-section-title">서비스</div>
                                    <a href="/search_history" class="dropdown-item">
                                        <div class="dropdown-icon-wrapper">
                                            <i class="dropdown-icon fa-solid fa-clock-rotate-left"></i>
                                        </div>
                                        <div class="dropdown-item-content">
                                            <div class="dropdown-item-title">서비스 뭐 넣지</div>
                                            <div class="dropdown-item-description">아이디어구상중</div>
                                        </div>
                                    </a>
                                </div>

								
<!--								<div class="downloadTest" id="downloadBtn" style="cursor: pointer; padding: 10px 15px; background-color: #4CAF50; color: white; border-radius: 4px; display: inline-block; margin: 10px 0;">-->
<!--								    <i class="fa-solid fa-download"></i> 아파트 데이터 다운로드-->
<!--								</div>-->
								
								
                                <!-- 관리자 섹션 -->
                                <c:if test="${user.userAdmin == 1}">
                                <div class="dropdown-section">
                                    <div class="dropdown-section-title">관리자</div>
                                    <a href="admin_view" class="dropdown-item admin-item">
                                        <div class="dropdown-icon-wrapper">
                                            <i class="dropdown-icon fa-solid fa-gear"></i>
                                        </div>
                                        <div class="dropdown-item-content">
                                            <div class="dropdown-item-title">관리자모드 <span class="admin-badge">Admin</span></div>
                                            <div class="dropdown-item-description">사이트 관리 및 설정</div>
                                        </div>
                                    </a>
                                    <a href="down" class="dropdown-item admin-item">
                                        <div class="dropdown-icon-wrapper">
                                            <i class="dropdown-icon fa-solid fa-download"></i>
                                        </div>
                                        <div class="dropdown-item-content">
                                            <div class="dropdown-item-title">아파트 데이터 다운로드 <span class="admin-badge">Admin</span></div>
                                            <div class="dropdown-item-description">아파트 데이터 다운로드</div>
                                        </div>
                                    </a>
                                </div>
                                </c:if>
                            </div>

                            <!-- 드롭다운 푸터 -->
                            <div class="dropdown-footer">
                                <a href="/privacy" class="dropdown-footer-link">개인정보처리방침</a>
                                <a href="/logout" class="logout-button">
                                    <i class="fa-solid fa-right-from-bracket"></i>
                                    로그아웃
                                </a>
                            </div>
                        </div>
                    </div>
                    </c:when>
                    <c:otherwise>
                    <!-- 로그인/회원가입 버튼 -->
                    <div class="auth-buttons">
                        <a href="/loginForm" class="auth-link login-link">
                            <i class="fa-solid fa-right-to-bracket"></i> 로그인
                        </a>
                        <a href="/joinForm" class="auth-link register-link">
                            <i class="fa-solid fa-user-plus"></i> 회원가입
                        </a>
                    </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>
	<!-- 토큰 만료 시간 관리 컴포넌트 -->
	<c:if test="${user != null}">
	<div class="token-expiry-manager" id="tokenExpiryManager">
	    <div class="token-card">
	        <div class="token-header">
	            <div class="token-title">
	                <i class="fas fa-clock"></i> 세션 만료 시간
	            </div>
	            <div class="token-actions">
	                <button id="extendTokenBtn" class="token-extend-btn">
	                    <i class="fas fa-sync-alt"></i> 연장하기
	                </button>
	                <button id="toggleTokenBtn" class="token-toggle-btn">
	                    <i class="fas fa-chevron-up"></i>
	                </button>
	            </div>
	        </div>
	        
	        <div class="token-body" id="tokenBody">
	            <div class="token-info">
	                <span>남은 시간</span>
	                <span id="remainingTime">--:--</span>
	            </div>
	            
	            <div class="progress-container">
	                <div id="progressBar" class="progress-bar"></div>
	            </div>
	            
	            <div class="token-expiry">
	                <span>* 시간이 만료되면 자동으로 로그아웃됩니다.</span>
	            </div>
	        </div>
	    </div>
	    
	    <!-- 접힌 상태일 때 표시될 미니 타이머 -->
	    <div class="token-mini" id="tokenMini">
	        <i class="fas fa-clock"></i> <span id="miniRemainingTime">--:--</span>
	    </div>
	</div>
	</c:if>
	
    <script src="/resources/js/token_manager.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 사용자 드롭다운 기능
            const dropdownToggle = document.getElementById('dropdownToggle');
            const userDropdown = document.getElementById('userDropdown');

            if (dropdownToggle && userDropdown) {
                dropdownToggle.addEventListener('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    userDropdown.classList.toggle('active');
                });

                // 외부 클릭 시 드롭다운 닫기
                document.addEventListener('click', function(e) {
                    if (userDropdown && !userDropdown.contains(e.target)) {
                        userDropdown.classList.remove('active');
                    }
                });
            }

            // 헤더 스크롤 효과
            const header = document.querySelector('.top-header');
            window.addEventListener('scroll', function() {
                if (window.scrollY > 10) {
                    header.classList.add('scrolled');
                } else {
                    header.classList.remove('scrolled');
                }
            });

            // 초기 스크롤 위치 확인
            if (window.scrollY > 10) {
                header.classList.add('scrolled');
            }
        });
    </script>
	
	<script>
		document.addEventListener('DOMContentLoaded', function() {
		    // 다운로드 링크 이벤트 리스너 (클래스로 선택)
		    const downloadLink = document.querySelector('a.dropdown-item.admin-item[href="down"]');
		    
		    if (downloadLink) {
		        downloadLink.addEventListener('click', function(event) {
		            // 기본 링크 동작 방지
		            event.preventDefault();
		            
		            // 링크 상태 변경 (비활성화 및 로딩 표시)
		            downloadLink.style.pointerEvents = 'none';
		            const iconWrapper = downloadLink.querySelector('.dropdown-icon-wrapper');
		            const originalIcon = iconWrapper.innerHTML;
		            iconWrapper.innerHTML = '<i class="dropdown-icon fa-solid fa-spinner fa-spin"></i>';
		            
		            const titleElement = downloadLink.querySelector('.dropdown-item-title');
		            const originalTitle = titleElement.innerHTML;
		            titleElement.innerHTML = '데이터 수집 중... <span class="admin-badge">Admin</span>';
		            
		            // 현재 연월 계산 (기본값: 이전 달)
		            const today = new Date();
		            const lastMonth = new Date(today.getFullYear(), today.getMonth() - 1);
		            const yearMonth = lastMonth.getFullYear().toString() + 
		                             (lastMonth.getMonth() + 1).toString().padStart(2, '0');
		            
		            // API 호출
		            fetch('/download?yearMonth=' + yearMonth)
		                .then(response => {
		                    if (!response.ok) {
		                        throw new Error('서버 응답 오류: ' + response.status);
		                    }
		                    return response.json();
		                })
		                .then(data => {
		                    // 성공 메시지 표시
		                    alert('아파트 데이터 수집 및 저장이 완료되었습니다.\n총 ' + data.length + '개의 데이터가 저장되었습니다.');
		                    
		                    // 링크 상태 복원
		                    iconWrapper.innerHTML = originalIcon;
		                    titleElement.innerHTML = originalTitle;
		                    downloadLink.style.pointerEvents = 'auto';
		                })
		                .catch(error => {
		                    // 오류 메시지 표시
		                    console.error('데이터 수집 중 오류 발생:', error);
		                    alert('데이터 수집 중 오류가 발생했습니다: ' + error.message);
		                    
		                    // 링크 상태 복원
		                    iconWrapper.innerHTML = originalIcon;
		                    titleElement.innerHTML = originalTitle;
		                    downloadLink.style.pointerEvents = 'auto';
		                });
		        });
		    } else {
		        console.error('아파트 데이터 다운로드 링크를 찾을 수 없습니다.');
		    }
		});
	</script>
</body>
</html>