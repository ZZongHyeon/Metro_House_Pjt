<%@page import="com.boot.dto.UserDTO"%>
<%@page import="java.util.List"%>
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
<title>마이페이지 - 잉크 트리</title>
<link rel="stylesheet" type="text/css"
	href="/pilotpjt/resources/css/mypage.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="/pilotpjt/resources/js/mypage.js"></script>
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
			url : "book_return",
			success : function(data) {
				alert("정상적으로 반납되었습니다.");
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
		response.sendRedirect("/pilotpjt/loginView");
		return;
	}

	Object userBorrowedBooksObj = request.getAttribute("userBorrowedBooks"); // 유저 현재 빌린 수
	Object userBeforReturnCountObj = request.getAttribute("userRecord"); // 빌리자마자 올라가는 borrow 수
	Object userRecordCountObj = request.getAttribute("userRecordCount"); // 반납하면 올라가는 borrow 수
	int borrowingCount = 0; // 유저 현재 빌린 수
	int recordCount = 0; // 빌리자마자 올라가는 수
	int afterReturnCount = 0; // 반납하면 올라가는 수

	if (userBorrowedBooksObj != null) {
		try {
			borrowingCount = Integer.parseInt(String.valueOf(userBorrowedBooksObj));
		} catch (NumberFormatException e) {
			// 변환 실패 시 기본값 유지
		}
	}
	if (userBeforReturnCountObj != null) {
		try {
			recordCount = Integer.parseInt(String.valueOf(userBeforReturnCountObj));
		} catch (NumberFormatException e) {
			// 변환 실패 시 기본값 유지
		}
	}
	if (userRecordCountObj != null) {
		try {
			afterReturnCount = Integer.parseInt(String.valueOf(userRecordCountObj));
		} catch (NumberFormatException e) {
			// 변환 실패 시 기본값 유지
		}
	}
	// 연체 도서 수 (예시 데이터)
	int overdueCount = 0;
	%>

	<div class="mypage-container">
		<div class="mypage-header">
			<h1 class="mypage-title">마이페이지</h1>
			<p class="mypage-subtitle">회원 정보 및 도서 대출 현황을 확인하실 수 있습니다.</p>
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
					<div class="menu-item" onclick="showTab('books')">
						<i class="fas fa-book"></i> <span>대출 현황 & 기록</span>
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
								<i class="fas fa-book"></i>
							</div>
							<div class="stat-value"><%=borrowingCount%></div>
							<div class="stat-label">대출 중인 도서</div>
						</div>

						<div class="stat-card">
							<div class="stat-icon">
								<i class="fas fa-exclamation-circle"></i>
							</div>
							<div class="stat-value">${userOver}</div>
							<div class="stat-label">연체 도서</div>
						</div>

						<div class="stat-card">
							<div class="stat-icon">
								<i class="fas fa-clock"></i>
							</div>
							<div class="stat-value">${userRecord}</div>
							<div class="stat-label">총 대출 이력</div>
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
						<a href="/pilotpjt/edit_profile" class="btn btn-primary"> <i
							class="fas fa-pen-to-square"></i> 정보 수정
						</a>
					</div>
				</div>

				<div id="books-tab" class="tab-content">
					<div class="section-header">
						<h2 class="section-title">대출 현황</h2>
					</div>


					<div class="tab-container">
						<div class="tab-buttons">
							<button class="tab-button active"
								onclick="showHistoryTab('borrowed', event)">대출 중</button>
							<button class="tab-button"
								onclick="showHistoryTab('returnRecord', event)">대출 기록</button>
						</div>


						<div id="borrowed" class="tab-content active">
							<%
							if (borrowingCount > 0) {
							%>
							<div class="book-list">
								<c:forEach var="book" items="${bookBorrowedList}">

									<div class="book-item">
										<div class="book-cover">
											<div class="book-cover-placeholder">
												<i class="fas fa-book"></i>
											</div>
										</div>
										<div class="book-info">
											<div class="book-title">${book.bookTitle}</div>
											<div class="book-author">${book.bookWrite}</div>
											<div class="book-dates">
												<span>대출일 : ${book.bookBorrowDate}</span> <span>반납예정일
													: ${book.bookReturnDate}</span>
											</div>
										</div>
										<div class="book-status status-borrowed">대출 중</div>
										<div class="book-status status-return">
											<form class="returnForm"
												style="display: inline-block; margin-top: 10px;">
												<input type="hidden" name="bookNumber"
													value="${book.bookNumber}">
												<button type="button" class="return-button"
													onclick="return_submit(this)">
													<i class="fas fa-undo-alt"></i> 반납하기
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
									<i class="fas fa-book"></i>
								</div>
								<div class="empty-message">현재 대출 중인 도서가 없습니다.</div>
								<a href="book_search_view" class="btn btn-outline"> <i
									class="fas fa-search"></i> 도서 검색하기
								</a>
							</div>
							<%
							}
							%>
						</div>
						<!-- 대출기록 -->
						<div id="returnRecord" class="tab-content">
							<%
							if (afterReturnCount > 0) {
							%>
							<div class="book-list">
								<c:forEach var="bookBorrowRecord" items="${bookBorrowList}">
									<div class="book-item">
										<div class="book-cover">
											<div class="book-cover-placeholder">
												<i class="fas fa-book"></i>
											</div>
										</div>
										<div class="book-info">
											<div class="book-title">${bookBorrowRecord.bookTitle}</div>
											<div class="book-author">${bookBorrowRecord.bookWrite}</div>
											<div class="book-dates">
												<span>대출일 : ${bookBorrowRecord.bookBorrowDate}</span> <span>반납일
													: ${bookBorrowRecord.bookReturnDate}</span>
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
									<i class="fas fa-book"></i>
								</div>
								<div class="empty-message">대출 기록이 없습니다.</div>
								<a href="book_search_view" class="btn btn-outline"> <i
									class="fas fa-search"></i> 도서 검색하기
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
									style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 4px;"
									required>
								<div id="passwordError"
									style="color: #f44336; font-size: 13px; margin-top: 5px;"></div>
							</div>

							<div class="info-item">
								<div class="info-label">새 비밀번호</div>

								<input type="password" id="newPassword" name="userNewPw"
									class="form-input" value="${userNewPw}"
									style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 4px;"
									required>
								<div class="info-label"
									style="margin-top: 5px; font-size: 12px; color: #999;">*
									8자 이상, 영문, 숫자, 특수문자 조합</div>
							</div>

							<div class="info-item">
								<div class="info-label">새 비밀번호 확인</div>

								<input type="password" id="confirmPassword"
									name="userNewPwCheck" class="form-input"
									value="${userNewPwCheck}"
									style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 4px;"
									required>
								<div id="passwordError"
									style="color: #f44336; font-size: 13px; margin-top: 5px;"></div>
							</div>
						</div>


						<div class="action-buttons">
							<!--변경된 부분 button type = submit -> button, onclick 추가 -->
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
	<!-- 2025-04-10 수정 시작 -->
	<c:if test="${not empty return_successMSG}">
		<script>
			alert("${return_successMSG}");
		</script>
	</c:if>
	<c:if test="${not empty return_errorMsg}">
		<script>
			alert("${return_errorMsg}");
		</script>
	</c:if>
	<!-- 2025-04-10 수정 종료 -->

</body>
</html>