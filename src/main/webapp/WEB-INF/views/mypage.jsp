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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
			<script>
			    // 페이지 로드 시 성공 메시지 표시
			    window.onload = function() {
			        <c:if test="${not empty successMsg}">
			            alert("${successMsg}");
			        </c:if>
			    };
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
					<div class="menu-item" onclick="showTab('profile', event)">
						<i class="fas fa-user"></i> <span>내 정보</span>
					</div>
					<div class="menu-item" onclick="showTab('favorites', event)">
						<i class="fas fa-heart"></i> <span>관심 아파트</span>
					</div>
					<div class="menu-item" onclick="showTab('update', event)">
						<i class="fas fa-pen-to-square"></i> <span>정보 수정</span>
					</div>
					<div class="menu-item" onclick="showTab('password', event)">
						<i class="fas fa-lock"></i> <span>비밀번호 변경</span>
					</div>
				</div>
			</div>

			<div class="content-section">
				<div id="profile-tab" class="tab-content">
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
						<button onclick="showTab('update', event)" class="btn btn-primary">
							<i class="fas fa-pen-to-square"></i> 정보 수정
						</button>
					</div>
				</div>

				<div id="favorites-tab" class="tab-content">
					<div class="section-header">
						<h2 class="section-title">관심 아파트</h2>
					</div>

					<div class="tab-container">
						<div class="tab-buttons">
							<button class="tab-button"
								onclick="showHistoryTab('current', event)">관심 목록</button>
							<button class="tab-button"
								onclick="showHistoryTab('history', event)">조회 기록</button>
						</div>

						<div id="current" class="tab-content">
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
								<a href="search_map?majorRegion=서울&district=강남구&station=강남역" class="btn btn-outline"> <i
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
								<a href="search_map?majorRegion=서울&district=강남구&station=강남역" class="btn btn-outline"> <i
									class="fas fa-search"></i> 아파트 검색하기
								</a>
							</div>
							<%
							}
							%>
						</div>
					</div>
				</div>
				
				<!-- 정보 수정 탭 추가 -->
				<div id="update-tab" class="tab-content">
					<div class="section-header">
						<h2 class="section-title">정보 수정</h2>
						<div class="section-subtitle">회원 정보를 수정하려면 현재 비밀번호를 입력해주세요.</div>
					</div>
					
					<form id="updateUserForm" method="post" action="userUpdate">
					    <input type="hidden" name="userNumber" value="<%=user.getUserNumber()%>">
					    <input type="hidden" name="userId" value="<%=user.getUserId()%>">
						
						<!-- 비밀번호 확인 섹션 추가 -->
						<div class="password-verification" style="margin-bottom: 30px; padding: 20px; background-color: var(--primary-lighter); border-radius: var(--border-radius); border: 1px solid var(--primary-light);">
						    <div class="info-label" style="margin-bottom: 15px; color: var(--primary-dark); font-weight: 600;">
						        <i class="fas fa-shield-alt" style="margin-right: 8px;"></i> 보안 확인
						    </div>
						    <div style="background-color: white; padding: 15px; border-radius: var(--border-radius-sm);">
						        <div class="info-label">현재 비밀번호</div>
						        <input type="password" id="updateCurrentPassword" name="userPw" class="form-input" placeholder="현재 비밀번호를 입력해주세요" required>
						        <div class="info-description" style="font-size: 13px; color: var(--gray-500); margin-top: 8px;">
						            * 회원 정보 보호를 위해 현재 비밀번호를 확인합니다.
						        </div>
						    </div>
						</div>
						
						<div class="info-grid">
							<div class="info-item">
								<div class="info-label">이름</div>
								<input type="text" name="userName" class="form-input" value="<%=user.getUserName()%>" required>
							</div>
							
							<div class="info-item">
								<div class="info-label">아이디</div>
								<div class="info-value"><%=user.getUserId()%></div>
							</div>
							
							<div class="info-item">
								<div class="info-label">이메일</div>
								<input type="email" name="userEmail" class="form-input" value="<%=user.getUserEmail()%>" required>
							</div>
							
							<div class="info-item">
								<div class="info-label">전화번호</div>
								<input type="tel" name="userTel" class="form-input" value="<%=user.getUserTel()%>" 
									pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" placeholder="010-0000-0000" required>
							</div>
							
							<div class="info-item">
								<div class="info-label">생년월일</div>
								<input type="date" name="userBirth" class="form-input" value="<%=user.getUserBirth()%>" required>
							</div>
							
							<div class="info-item">
								<div class="info-label">가입일</div>
								<div class="info-value"><%=user.getUserRegdate()%></div>
							</div>
						</div>
						
						<div class="address-section" style="margin-top: 20px;">
							<div class="info-item" style="grid-column: span 2;">
								<div class="info-label">우편번호</div>
								<div style="display: flex; gap: 10px;">
									<input type="text" name="userZipCode" id="userZipCode" class="form-input" 
										value="<%=user.getUserZipCode()%>" style="flex: 1;" readonly>
									<button type="button" onclick="execDaumPostcode()" class="btn btn-outline" style="white-space: nowrap;">
										<i class="fas fa-search"></i> 주소 찾기
									</button>
								</div>
							</div>
							
							<div class="info-item" style="grid-column: span 2;">
								<div class="info-label">주소</div>
								<input type="text" name="userAddress" id="userAddress" class="form-input" 
									value="<%=user.getUserAddress()%>" readonly>
							</div>
							
							<div class="info-item" style="grid-column: span 2;">
								<div class="info-label">상세주소</div>
								<input type="text" name="userDetailAddress" id="userDetailAddress" class="form-input" 
									value="<%=user.getUserDetailAddress()%>">
							</div>
						</div>
						
						<div class="action-buttons">
						    <button type="submit" class="btn btn-primary">
						        <i class="fas fa-check"></i> 정보 수정 완료
						    </button>
						    <button type="button" onclick="showTab('profile', event)" class="btn btn-outline">
						        <i class="fas fa-times"></i> 취소
						    </button>
						</div>
					</form>
				</div>

				<div id="password-tab" class="tab-content">
					<div class="section-header">
						<h2 class="section-title">비밀번호 변경</h2>
					</div>
					<form id="passwordChangeForm" onsubmit="return false;">
					    <input type="hidden" name="userNumber" value="<%=user.getUserNumber()%>">
					    <div class="info-grid" style="grid-template-columns: 1fr;">
					        <div class="info-item">
					            <div class="info-label">현재 비밀번호</div>
					            <input type="password" id="currentPassword" name="userPw" class="form-input" required>
					            <div id="passwordError" style="color: var(--danger); font-size: 13px; margin-top: 5px;"></div>
					        </div>

					        <div class="info-item">
					            <div class="info-label">새 비밀번호</div>
					            <input type="password" id="newPassword" name="userNewPw" class="form-input" required>
					            <div class="info-label" style="margin-top: 5px; font-size: 12px; color: var(--gray-500);">*
					                8자 이상, 영문, 숫자, 특수문자 조합</div>
					        </div>

					        <div class="info-item">
					            <div class="info-label">새 비밀번호 확인</div>
					            <input type="password" id="confirmPassword" name="userNewPwCheck" class="form-input" required>
					            <div id="passwordError" style="color: var(--danger); font-size: 13px; margin-top: 5px;"></div>
					        </div>
					    </div>

					    <div class="action-buttons">
					        <button type="button" onclick="changePassword()" class="btn btn-primary">
					            <i class="fas fa-check"></i> 비밀번호 변경
					        </button>
					        <button type="button" onclick="showTab('profile', event)" class="btn btn-outline">
					            <i class="fas fa-times"></i> 취소
					        </button>
					    </div>
					</form>
<!--					<form action="userPwUpdate" method="post"-->
<!--						onsubmit="return validatePasswordForm()">-->
<!--						<input type="hidden" name="userNumber"-->
<!--							value="<%=user.getUserNumber()%>">-->
<!--						<div class="info-grid" style="grid-template-columns: 1fr;">-->
<!--							<div class="info-item">-->
<!--								<div class="info-label">현재 비밀번호</div>-->

<!--								<input type="password" id="currentPassword" name="userPw"-->
<!--									class="form-input" value="${userPw}"-->
<!--									required>-->
<!--								<div id="passwordError"-->
<!--									style="color: var(--danger); font-size: 13px; margin-top: 5px;"></div>-->
<!--							</div>-->

<!--							<div class="info-item">-->
<!--								<div class="info-label">새 비밀번호</div>-->

<!--								<input type="password" id="newPassword" name="userNewPw"-->
<!--									class="form-input" value="${userNewPw}"-->
<!--									required>-->
<!--								<div class="info-label"-->
<!--									style="margin-top: 5px; font-size: 12px; color: var(--gray-500);">*-->
<!--									8자 이상, 영문, 숫자, 특수문자 조합</div>-->
<!--							</div>-->

<!--							<div class="info-item">-->
<!--								<div class="info-label">새 비밀번호 확인</div>-->

<!--								<input type="password" id="confirmPassword"-->
<!--									name="userNewPwCheck" class="form-input"-->
<!--									value="${userNewPwCheck}"-->
<!--									required>-->
<!--								<div id="passwordError"-->
<!--									style="color: var(--danger); font-size: 13px; margin-top: 5px;"></div>-->
<!--							</div>-->
<!--						</div>-->

<!--						<div class="action-buttons">-->
<!--							<button type="submit" class="btn btn-primary">-->
<!--								<i class="fas fa-check"></i> 비밀번호 변경-->
<!--							</button>-->
<!--							<button type="button" onclick="showTab('profile', event)" class="btn btn-outline">-->
<!--								<i class="fas fa-times"></i> 취소-->
<!--							</button>-->
<!--						</div>-->
<!--					</form>-->
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
	
</body>
</html>