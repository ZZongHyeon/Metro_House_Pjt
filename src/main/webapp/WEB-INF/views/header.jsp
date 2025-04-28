<%@page import="com.boot.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>메트로하우스 - 지하철역 주변 아파트 시세</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" type="text/css"
	href="/resources/css/header.css">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<script>
	window.addEventListener("unload", function() {
		navigator.sendBeacon("/disconnect");
	});
</script>
</head>
<body>
	<%
	UserDTO user = (UserDTO) session.getAttribute("loginUser");
	String currentPage = request.getRequestURI();
	%>
	<header class="top-header">
		<div class="header-container">
			<div class="logo-section">
				<a href="/main" class="logo-link"> <img
					src="/resources/images/logo_2.png" alt="MetroHouse"
					class="logo-img"
					onerror="this.src='/resources/images/default-logo.png'; this.onerror=null;">
					<span class="logo-text">메트로하우스</span>
				</a>
			</div>

			<button class="mobile-menu-toggle" id="mobileMenuToggle">
				<i class="fas fa-bars"></i>
			</button>

			<nav class="nav-links" id="navLinks">
				<a href="main" class="nav-link <%=currentPage.contains("main") ? "active" : ""%>">
					<i class="nav-icon fa-solid fa-house"></i> <span>메인</span>
				</a> <a href="board_view"
					class="nav-link <%=currentPage.contains("board_view") ? "active" : ""%>">
					<i class="nav-icon fa-solid fa-clipboard-list"></i> <span>게시판</span>
				</a> <a href="/search_map?majorRegion=서울&district=강남구&station=강남역"
					class="nav-link <%=currentPage.contains("search_map") ? "active" : ""%>">
					<i class="nav-icon fa-solid fa-map"></i> <span>지도</span>
				</a>

				<%
				if (user != null) {
				%>
				<a href="user_favorite_apartments"
					class="nav-link <%=currentPage.contains("user_favorite_apartments") ? "active" : ""%>">
					<i class="nav-icon fa-solid fa-heart"></i> <span>관심아파트</span>
				</a>
				<%
				}
				%>

				<div class="mobile-auth" id="mobileAuth" style="display: none;">
					<%
					if (user == null) {
					%>
					<a href="/loginView" class="auth-link login-link"> <i
						class="fa-solid fa-right-to-bracket"></i> 로그인
					</a> <a href="/joinView" class="auth-link register-link">
						<i class="fa-solid fa-user-plus"></i> 회원가입
					</a>
					<%
					}
					%>
				</div>
			</nav>


			<div class="user-menu">
				<%
				if (user != null) {
				%>
				<div class="user-dropdown" id="userDropdown">
					<button class="dropdown-toggle" id="dropdownToggle">
						<div class="user-avatar">
							<%=user.getUserName().substring(0, 1)%>
						</div>
						<span class="user-name"><%=user.getUserName()%> 님</span> <span
							class="toggle-icon"><i class="fa-solid fa-chevron-down"></i></span>
					</button>
					<div class="dropdown-menu">
						<div class="dropdown-header">
							<div class="user-avatar large">
								<%=user.getUserName().substring(0, 1)%>
							</div>
							<div class="header-info">
								<div class="header-name"><%=user.getUserName()%>
									님
								</div>
								<div class="header-email"><%=user.getUserEmail()%></div>
							</div>
						</div>

						<div class="dropdown-divider"></div>

						<a href="mypage" class="dropdown-item"> <i
							class="dropdown-icon fa-solid fa-user"></i> <span>마이페이지</span>
						</a> <a href="/user_update_view" class="dropdown-item"> <i
							class="dropdown-icon fa-solid fa-pen-to-square"></i> <span>내정보수정</span>
						</a>

						<%
						if (user.getUserAdmin() == 1) {
						%>
						<div class="dropdown-divider"></div>
						<a href="admin_view" class="dropdown-item admin-item"> <i
							class="dropdown-icon fa-solid fa-gear"></i> <span>관리자모드</span> <span
							class="admin-badge">Admin</span>
						</a>
						<%
						}
						%>

						<div class="dropdown-divider"></div>
						<a href="/logout" class="dropdown-item"> <i
							class="dropdown-icon fa-solid fa-right-from-bracket"></i> <span>로그아웃</span>
						</a>
					</div>
				</div>
				<%
				} else {
				%>
				<div class="auth-buttons">
					<a href="/loginView" class="auth-link login-link"> <i
						class="fa-solid fa-right-to-bracket"></i> 로그인
					</a> <a href="/joinView" class="auth-link register-link">
						<i class="fa-solid fa-user-plus"></i> 회원가입
					</a>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</header>

	<script>
		document.addEventListener('DOMContentLoaded', function() {
			// User dropdown functionality
			const dropdownToggle = document.getElementById('dropdownToggle');
			const userDropdown = document.getElementById('userDropdown');

			if (dropdownToggle) {
				dropdownToggle.addEventListener('click', function(e) {
					e.preventDefault();
					userDropdown.classList.toggle('active');
				});

				// Close dropdown when clicking outside
				document.addEventListener('click', function(e) {
					if (userDropdown && !userDropdown.contains(e.target)) {
						userDropdown.classList.remove('active');
					}
				});
			}

			// Mobile menu functionality
			const mobileMenuToggle = document
					.getElementById('mobileMenuToggle');
			const navLinks = document.getElementById('navLinks');
			const mobileAuth = document.getElementById('mobileAuth');

			if (mobileMenuToggle) {
				mobileMenuToggle.addEventListener('click', function() {
					navLinks.classList.toggle('active');

					// Toggle icon between bars and times
					const icon = mobileMenuToggle.querySelector('i');
					if (navLinks.classList.contains('active')) {
						icon.classList.remove('fa-bars');
						icon.classList.add('fa-times');
						if (mobileAuth)
							mobileAuth.style.display = 'flex';
					} else {
						icon.classList.remove('fa-times');
						icon.classList.add('fa-bars');
						if (mobileAuth)
							mobileAuth.style.display = 'none';
					}
				});
			}

			// Header scroll effect
			const header = document.querySelector('.top-header');
			window.addEventListener('scroll', function() {
				if (window.scrollY > 10) {
					header.classList.add('scrolled');
				} else {
					header.classList.remove('scrolled');
				}
			});

			// Check initial scroll position
			if (window.scrollY > 10) {
				header.classList.add('scrolled');
			}

			// Close mobile menu on window resize if screen becomes larger
			window.addEventListener('resize', function() {
				if (window.innerWidth > 768
						&& navLinks.classList.contains('active')) {
					navLinks.classList.remove('active');
					const icon = mobileMenuToggle.querySelector('i');
					icon.classList.remove('fa-times');
					icon.classList.add('fa-bars');
					if (mobileAuth)
						mobileAuth.style.display = 'none';
				}
			});
		});
	</script>
</body>
</html>