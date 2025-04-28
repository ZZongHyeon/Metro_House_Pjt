<%@page import="com.boot.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지 - 메트로하우스</title>
<link rel="stylesheet" type="text/css"
	href="/resources/css/mypage.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="/resources/js/mypage.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<script type="text/javascript">
	function return_submit(button) {
		const form = button.closest("form"); // 해당 버튼의 form
		if (!form.checkValidity()) {
			form.reportValidity();
			return;
		}

		const formData = $(form).serialize(); // 개별 form 기준으로 serialize

		$.ajax({
			type : "post",
			data : formData,
			url : "apartment_favorite_remove",
			success : function(data) {
				alert("정상적으로 처리되었습니다.");
				location.href = "mypage"; // 새로고침
			},
			error : function() {
				alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
			}
		});
	}
</script>
</head>
<body>
	<jsp:include page="header.jsp" />

	<%
	UserDTO user = (UserDTO) session.getAttribute("loginUser");
	if (user == null) {
		response.sendRedirect("/loginView");
		return;
	}

	Object userFavoriteCountObj = request.getAttribute("userFavoriteCount"); // 관심 아파트 수
	Object userViewCountObj = request.getAttribute("userViewCount"); // 조회한 아파트 수
	Object userSearchCountObj = request.getAttribute("userSearchCount"); // 검색 횟수
	int favoriteCount = 0; 
	int viewCount = 0; 
	int searchCount = 0; 

	if (userFavoriteCountObj != null) {
		try {
			favoriteCount = Integer.parseInt(String.valueOf(userFavoriteCountObj));
		} catch (NumberFormatException e) {
			// 변환 실패 시 기본값 유지
		}
	}
	if (userViewCountObj != null) {
		try {
			viewCount = Integer.parseInt(String.valueOf(userViewCountObj));
		} catch (NumberFormatException e) {
			// 변환 실패 시 기본값 유지
		}
	}
	if (userSearchCountObj != null) {
		try {
			searchCount = Integer.parseInt(String.valueOf(userSearchCountObj));
		} catch (NumberFormatException e) {
			// 변환 실패 시 기본값 유지
		}
	}
	%>

	<div class="mypage-container">
		<div class="mypage-header">
			<h1 class="mypage-title">마이페이지</h1>
			<p class="mypage-subtitle">회원 정보 및 아파트 관심 목록을 확인하실 수 있습니다.</p>
		</div>

		<div class="mypage-content">
			<div class="profile-sidebar">
				<div class="profile-header">
					<div class="profile-avatar"><%=user.getUserName().substring(0, 1)%></div>
					<div class="profile-name"><%=user.getUserName()%>
						님
					</div>
					<div class="profile-id"><%=user.getUserId()%></div>
				</div>

				<div class="profile-menu">
					<div class="menu-item active" onclick="showTab('profile')">
						<i class="fas fa-user"></i> <span>내 정보</span>
					</div>
					<div class="menu-item" onclick="showTab('favorites')">
						<i class="fas fa-heart"></i> <span>관심 아파트</span>
					</div>
					<a href="user_update_view" class="menu-item"> <i
						class="fas fa-pen-to-square"></i> <span>정보 수정</span>
					</a>
					<div class="menu-item" onclick="showTab('password')">
						<i class="fas fa-lock"></i> <span>비밀번호 변경</span>
					</div>
				</div>
			</div>

			<div class="content-section">
				<div id="profile-tab" class="tab-content active">
					<div class="section-header">
						<h2 class="section-title">내 정보</h2>
					</div>

					<div class="stats-container">
						<div class="stat-card">
							<div class="stat-icon">
								<i class="fas fa-heart"></i>
							</div>
							<div class="stat-value"><%=favoriteCount%></div>
							<div class="stat-label">관심 아파트</div>
						</div>

						<div class="stat-card">
							<div class="stat-icon">
								<i class="fas fa-eye"></i>
							</div>
							<div class="stat-value"><%=viewCount%></div>
							<div class="stat-label">조회한 아파트</div>
						</div>

						<div class="stat-card">
							<div class="stat-icon">
								<i class="fas fa-search"></i>
							</div>
							<div class="stat-value"><%=searchCount%></div>
							<div class="stat-label">검색 횟수</div>
						</div>
					</div>

					<div class="info-grid">
						<div class="info-item">
							<div class="info-label">이름</div>
							<div class="info-value"><%=user.getUserName()%></div>
						</div>

						<div class="info-item">
							<div class="info-label">아이디</div>
							<div class="info-value"><%=user.getUserId()%></div>
						</div>

						<div class="info-item">
							<div class="info-label">이메일</div>
							<div class="info-value"><%=user.getUserEmail()%></div>
						</div>

						<div class="info-item">
							<div class="info-label">전화번호</div>
							<div class="info-value"><%=user.getUserTel()%></div>
						</div>

						<div class="info-item">
							<div class="info-label">생년월일</div>
							<div class="info-value"><%=user.getUserBirth()%></div>
						</div>

						<div class="info-item">
							<div class="info-label">가입일</div>
							<div class="info-value"><%=user.getUserRegdate()%></div>
						</div>
					</div>

					<div class="info-item" style="grid-column: span 2;">
						<div class="info-label">주소</div>
						<div class="info-value">
							<%=user.getUserZipCode()%>
							<%=user.getUserAddress()%>
							<%=user.getUserDetailAddress()%>
						</div>
					</div>

					<div class="action-buttons">
						<a href="/edit_profile" class="btn btn-primary"> <i
							class="fas fa-pen-to-square"></i> 정보 수정
						</a>
					</div>
				</div>

				<div id="favorites-tab" class="tab-content">
					<div class="section-header">
						<h2 class="section-title">관심 아파트</h2>
					</div>

					<div class="tab-container">
						<div class="tab-buttons">
							<button class="tab-button active"
								onclick="showHistoryTab('current', event)">관심 목록</button>
							<button class="tab-button"
								onclick="showHistoryTab('history', event)">조회 기록</button>
						</div>

						<div id="current" class="tab-content active">
							<%
							if (favoriteCount > 0) {
							%>
							<div class="apartment-list">
								<c:forEach var="apartment" items="${favoriteApartments}">
									<div class="apartment-item">
										<div class="apartment-info">
											<div class="apartment-title">${apartment.apartmentName}</div>
											<div class="apartment-location">${apartment.district} ${apartment.dong}</div>
											<div class="apartment-details">
												<span>면적: ${apartment.size}㎡</span>
												<span>가격: <fmt:formatNumber value="${apartment.price}" type="number"/>만원</span>
											</div>
										</div>
										<div class="apartment-actions">
											<form class="favoriteForm" style="display: inline-block;">
												<input type="hidden" name="apartmentId" value="${apartment.apartmentId}">
												<button type="button" class="return-button" onclick="return_submit(this)">
													<i class="fas fa-heart-broken"></i> 관심 해제
												</button>
											</form>
										</div>
									</div>
								</c:forEach>
							</div>
							<%
							} else {
							%>
							<div class="empty-state">
								<div class="empty-icon">
									<i class="fas fa-heart"></i>
								</div>
								<div class="empty-message">관심 등록된 아파트가 없습니다.</div>
								<a href="apartment_search_view" class="btn btn-outline"> <i
									class="fas fa-search"></i> 아파트 검색하기
								</a>
							</div>
							<%
							}
							%>
						</div>
						
						<div id="history" class="tab-content">
							<%
							if (viewCount > 0) {
							%>
							<div class="apartment-list">
								<c:forEach var="apartment" items="${viewedApartments}">
									<div class="apartment-item">
										<div class="apartment-info">
											<div class="apartment-title">${apartment.apartmentName}</div>
											<div class="apartment-location">${apartment.district} ${apartment.dong}</div>
											<div class="apartment-details">
												<span>조회일: <fmt:formatDate value="${apartment.viewDate}" pattern="yyyy-MM-dd HH:mm"/></span>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
							<%
							} else {
							%>
							<div class="empty-state">
								<div class="empty-icon">
									<i class="fas fa-eye"></i>
								</div>
								<div class="empty-message">최근 조회한 아파트가 없습니다.</div>
								<a href="apartment_search_view" class="btn btn-outline"> <i
									class="fas fa-search"></i> 아파트 검색하기
								</a>
							</div>
							<%
							}
							%>
						</div>
					</div>
				</div>

				<div id="password-tab" class="tab-content">
					<div class="section-header">
						<h2 class="section-title">비밀번호 변경</h2>
					</div>

					<form action="userPwUpdate" method="post"
						onsubmit="return validatePasswordForm()">
						<input type="hidden" name="userNumber"
							value="<%=user.getUserNumber()%>">
						<div class="info-grid" style="grid-template-columns: 1fr;">
							<div class="info-item">
								<div class="info-label">현재 비밀번호</div>

								<input type="password" id="currentPassword" name="userPw"
									class="form-input" value="${userPw}"
									style="width: 100%; padding: 12px; border: 1px solid var(--gray-200); border-radius: var(--border-radius);"
									required>
								<div id="passwordError"
									style="color: var(--danger); font-size: 13px; margin-top: 5px;"></div>
							</div>

							<div class="info-item">
								<div class="info-label">새 비밀번호</div>

								<input type="password" id="newPassword" name="userNewPw"
									class="form-input" value="${userNewPw}"
									style="width: 100%; padding: 12px; border: 1px solid var(--gray-200); border-radius: var(--border-radius);"
									required>
								<div class="info-label"
									style="margin-top: 5px; font-size: 12px; color: var(--gray-500);">*
									8자 이상, 영문, 숫자, 특수문자 조합</div>
							</div>

							<div class="info-item">
								<div class="info-label">새 비밀번호 확인</div>

								<input type="password" id="confirmPassword"
									name="userNewPwCheck" class="form-input"
									value="${userNewPwCheck}"
									style="width: 100%; padding: 12px; border: 1px solid var(--gray-200); border-radius: var(--border-radius);"
									required>
								<div id="passwordError"
									style="color: var(--danger); font-size: 13px; margin-top: 5px;"></div>
							</div>
						</div>

						<div class="action-buttons">
							<button type="submit" class="btn btn-primary">
								<i class="fas fa-check"></i> 비밀번호 변경
							</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<c:if test="${not empty errorMsg}">
		<script>
			alert("${errorMsg}");
		</script>
	</c:if>
	<c:if test="${not empty successMsg}">
		<script>
			alert("${successMsg}");
		</script>
	</c:if>

	<script>
		// 탭 전환 함수
		function showTab(tabId) {
			// 모든 탭 컨텐츠 숨기기
			document.querySelectorAll('.content-section .tab-content').forEach(tab => {
				tab.classList.remove('active');
			});
			
			// 모든 메뉴 아이템 비활성화
			document.querySelectorAll('.menu-item').forEach(item => {
				item.classList.remove('active');
			});
			
			// 선택한 탭 컨텐츠 표시
			document.getElementById(tabId + '-tab').classList.add('active');
			
			// 선택한 메뉴 아이템 활성화
			event.currentTarget.classList.add('active');
		}
		
		// 히스토리 탭 전환 함수
		function showHistoryTab(tabId, event) {
			// 모든 탭 컨텐츠 숨기기
			document.querySelectorAll('.tab-container .tab-content').forEach(tab => {
				tab.classList.remove('active');
			});
			
			// 모든 탭 버튼 비활성화
			document.querySelectorAll('.tab-button').forEach(button => {
				button.classList.remove('active');
			});
			
			// 선택한 탭 컨텐츠 표시
			document.getElementById(tabId).classList.add('active');
			
			// 선택한 탭 버튼 활성화
			event.currentTarget.classList.add('active');
		}
		
		// 비밀번호 유효성 검사
		function validatePasswordForm() {
			const newPassword = document.getElementById('newPassword').value;
			const confirmPassword = document.getElementById('confirmPassword').value;
			
			// 비밀번호 일치 여부 확인
			if (newPassword !== confirmPassword) {
				alert('새 비밀번호와 확인 비밀번호가 일치하지 않습니다.');
				return false;
			}
			
			// 비밀번호 복잡성 검사
			const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
			if (!passwordRegex.test(newPassword)) {
				alert('비밀번호는 8자 이상, 영문, 숫자, 특수문자를 포함해야 합니다.');
				return false;
			}
			
			return true;
		}
	</script>
</body>
</html>
