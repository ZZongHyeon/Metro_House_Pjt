<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아파트 상세</title>
    
    <!-- 폰트 및 아이콘 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/resources/css/board_view.css">
    <link rel="stylesheet" type="text/css" href="/resources/css/apartment_detail.css">
</head>

<body>
    <jsp:include page="../header.jsp" />

    <div class="container">
<!--        <div class="page-header">-->
<!--            <h1 class="page-title">-->
<!--                <i class="fas fa-building"></i> 아파트 상세-->
<!--            </h1>-->
<!--            <a href="javascript:history.back()" class="back-link">-->
<!--                <i class="fas fa-arrow-left"></i> 목록으로 돌아가기-->
<!--            </a>-->
<!--        </div>-->

        <div class="apartment-detail fade-in">
            <!-- 좌측 사이드바 -->
            <div class="apartment-sidebar">
                <div class="apartment-title-container">
                    <h2 class="apartment-title">${apartment.aptNm}</h2>
                    <div class="admin-menu-container" id="adminMenuContainer" style="display: none;">
                        <button type="button" class="admin-menu-button" onclick="toggleAdminMenu()" aria-label="관리자 메뉴">
                            <i class="fa-solid fa-gear"></i>
                        </button>
                        <div class="admin-menu-dropdown" id="adminMenuDropdown">
                            <a href="/update_apartment?apartmentId=${apartment.apartmentId}" class="admin-menu-item">
                                <i class="fas fa-edit"></i> 아파트 정보 수정
                            </a>
                            <button type="button" class="admin-menu-item danger" onclick="confirmDelete(${apartment.apartmentId})">
                                <i class="fas fa-trash"></i> 아파트 삭제
                            </button>
                        </div>
                    </div>
                </div>
                
                <p class="apartment-location">${apartment.estateAgentSggNm}</p>
                
                <div class="apartment-categories">
                    <span class="apartment-category">매매</span>
                    <c:if test="${not empty apartment.dealAmount}">
                        <span class="apartment-price">${apartment.dealAmount}만원</span>
                    </c:if>
                </div>
                
                <div class="apartment-image-section">
                    <div class="apartment-cover">
                        <div class="apartment-cover-placeholder" id="placeholder-${apartment.apartmentId}">
                            <i class="fas fa-building"></i>
                        </div>
                    </div>

                    <div class="apartment-status">
                        <div class="status-badge available">
                            <i class="fas fa-check-circle"></i> 매매 가능
                        </div>
                        <div class="status-badge count-badge">
                            <i class="fas fa-home"></i> 면적: ${apartment.excluUseAr}㎡
                        </div>
<!--                        <div class="status-badge count-badge">-->
<!--                            <i class="fas fa-chart-line"></i> 조회: ${apartment.viewCount}회-->
<!--                        </div>-->
                    </div>

                    <div class="apartment-info-grid">
                        <div class="apartment-meta-item">
                            <span class="meta-label">건축년도</span>
                            <span class="meta-value">${apartment.buildYear}년</span>
                        </div>
                        <div class="apartment-meta-item">
                            <span class="meta-label">층수</span>
                            <span class="meta-value">${apartment.floor}층</span>
                        </div>
                        <div class="apartment-meta-item">
                            <span class="meta-label">지하철역</span>
                            <span class="meta-value">${apartment.subwayStation}</span>
                        </div>
                        <div class="apartment-meta-item">
                            <span class="meta-label">거리</span>
                            <span class="meta-value">${apartment.subwayDistance}m</span>
                        </div>
                    </div>

                    <div class="apartment-actions">
                        <button class="action-button primary-button" onclick="inquireApartment(${apartment.apartmentId})">
                            <i class="fas fa-phone"></i> 문의하기
                        </button>
                        <button class="action-button secondary-button" onclick="addToFavorites('${apartment.apartmentId}')">
                            <i class="fas fa-heart"></i> 관심목록에 추가
                        </button>
                    </div>
                </div>
            </div>

            <!-- 우측 콘텐츠 영역 -->
            <div class="apartment-content">
                <div class="tabs">
                    <ul class="tab-list" role="tablist">
                        <li class="tab-item active" role="tab" aria-selected="true" data-tab="description">아파트 정보</li>
                        <li class="tab-item" role="tab" aria-selected="false" data-tab="reviews">리뷰 및 평점</li>
                    </ul>

                    <div class="tab-content">
                        <div id="description" class="tab-panel active" role="tabpanel">
							그래프넣을예정
                        </div>

                        <div id="reviews" class="tab-panel" role="tabpanel">
                            <div class="reviews-section">
                                <div class="review-stats">
                                    <div class="average-rating">
                                        <div class="rating-value">${reviewStats.averageRating}</div>
                                        <div class="rating-stars">
                                            <c:forEach begin="1" end="5" var="i">
                                                <c:choose>
                                                    <c:when test="${i <= Math.floor(reviewStats.averageRating)}">
                                                        <i class="fas fa-star"></i>
                                                    </c:when>
                                                    <c:when test="${i == Math.ceil(reviewStats.averageRating) && reviewStats.averageRating % 1 != 0}">
                                                        <i class="fas fa-star-half-alt"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="far fa-star"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </div>
                                        <div class="rating-count">총 ${reviewStats.totalReviews}개 리뷰</div>
                                    </div>
                                    <div class="rating-distribution">
                                        <div class="rating-bar">
                                            <span class="rating-label">5</span>
                                            <div class="rating-progress">
                                                <div class="rating-progress-fill" style="width: ${reviewStats.fiveStarPercentage}%"></div>
                                            </div>
                                            <span class="rating-percent">${reviewStats.fiveStarPercentage}%</span>
                                        </div>
                                        <div class="rating-bar">
                                            <span class="rating-label">4</span>
                                            <div class="rating-progress">
                                                <div class="rating-progress-fill" style="width: ${reviewStats.fourStarPercentage}%"></div>
                                            </div>
                                            <span class="rating-percent">${reviewStats.fourStarPercentage}%</span>
                                        </div>
                                        <div class="rating-bar">
                                            <span class="rating-label">3</span>
                                            <div class="rating-progress">
                                                <div class="rating-progress-fill" style="width: ${reviewStats.threeStarPercentage}%"></div>
                                            </div>
                                            <span class="rating-percent">${reviewStats.threeStarPercentage}%</span>
                                        </div>
                                        <div class="rating-bar">
                                            <span class="rating-label">2</span>
                                            <div class="rating-progress">
                                                <div class="rating-progress-fill" style="width: ${reviewStats.twoStarPercentage}%"></div>
                                            </div>
                                            <span class="rating-percent">${reviewStats.twoStarPercentage}%</span>
                                        </div>
                                        <div class="rating-bar">
                                            <span class="rating-label">1</span>
                                            <div class="rating-progress">
                                                <div class="rating-progress-fill" style="width: ${reviewStats.oneStarPercentage}%"></div>
                                            </div>
                                            <span class="rating-percent">${reviewStats.oneStarPercentage}%</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="review-form">
                                    <h3 class="form-title">리뷰 작성하기</h3>
                                    <form id="reviewForm">
                                        <input type="hidden" name="reviewId" id="reviewId" value="">
                                        <input type="hidden" name="apartmentId" id="apartmentIdInput" value="${apartment.apartmentId}">
                                        <div class="form-group">
                                            <div class="rating-input">
                                                <i class="far fa-star" data-rating="1"></i>
                                                <i class="far fa-star" data-rating="2"></i>
                                                <i class="far fa-star" data-rating="3"></i>
                                                <i class="far fa-star" data-rating="4"></i>
                                                <i class="far fa-star" data-rating="5"></i>
                                            </div>
                                            <input type="hidden" name="rating" id="ratingInput" value="0">
                                        </div>
                                        <div class="form-group">
                                            <input type="text" class="form-control" id="reviewTitle" name="title" placeholder="리뷰 제목을 입력하세요" required>
                                        </div>
                                        <div class="form-group">
                                            <textarea class="form-control" id="reviewContent" name="content" placeholder="리뷰 내용을 입력하세요" required></textarea>
                                        </div>
                                        <div class="form-actions">
                                            <button type="button" class="action-button secondary-button" onclick="resetReviewForm()">초기화</button>
                                            <button type="button" class="action-button primary-button" onclick="submitReview()">리뷰 등록</button>
                                        </div>
                                    </form>
                                </div>

                                <div class="reviews-list">
                                    <!-- 리뷰 목록 반복 -->
                                    <c:forEach var="review" items="${reviewList}">
                                        <div class="review-card">
                                            <input type="hidden" class="review-id-hidden" value="${review.reviewId}">
                                            <div class="review-header">
                                                <div class="reviewer-info">
                                                    <div class="reviewer-name-date">
                                                        <span class="reviewer-name">${review.userName}</span>
                                                        <span class="review-date"><fmt:formatDate value="${review.reviewDate}" pattern="yyyy-MM-dd" /></span>
                                                    </div>
                                                </div>
                                                <div class="review-actions-top">
                                                    <span class="helpful-container">
                                                        <i class="${review.helpfulByCurrentUser ? 'fas' : 'far'} fa-thumbs-up review-action-icon like ${review.helpfulByCurrentUser ? 'active' : ''}" 
                                                           onclick="markHelpful(${review.reviewId}, this)" 
                                                           title="도움됨"></i>
                                                        <span class="helpful-count">${review.helpfulCount}</span>
                                                    </span>
                                                    <div class="review-edit-delete" style="display: none;" data-user-number="${review.userNumber}">
                                                        <i class="fas fa-edit review-action-icon edit" title="수정"></i>
                                                        <i class="fas fa-trash-alt review-action-icon delete" 
                                                           onclick="confirmDeleteReview(${review.reviewId})" 
                                                           title="삭제"></i>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="review-rating">
                                                <c:forEach begin="1" end="5" var="i">
                                                    <c:choose>
                                                        <c:when test="${i <= review.reviewRating}">
                                                            <i class="fas fa-star"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="far fa-star"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </div>
                                            
                                            <div class="review-title-rating">
                                                <h4 class="review-title">${review.reviewTitle}</h4>
                                            </div>
                                            
                                            <div class="review-content">
                                                <p>${review.reviewContent}</p>
                                            </div>
                                        </div>
                                    </c:forEach>

                                    <div class="div_page">
                                        <ul>
                                            <c:if test="${pageMaker.prev}">
                                                <li class="paginate_button">
                                                    <a href="${pageMaker.startPage - 1}">
                                                        <i class="fas fa-caret-left"></i>
                                                    </a>
                                                </li>
                                            </c:if>

                                            <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                                                <li class="paginate_button ${pageMaker.noticeCriteriaDTO.pageNum==num ? 'active' : ''}">
                                                    <a href="${num}">${num}</a>
                                                </li>
                                            </c:forEach>

                                            <c:if test="${pageMaker.next}">
                                                <li class="paginate_button">
                                                    <a href="${pageMaker.endPage+1}">
                                                        <i class="fas fa-caret-right"></i>
                                                    </a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </div>
                                    
                                    <form id="actionForm" action="apartment_detail" method="get">
                                        <input type="hidden" name="pageNum" value="${pageMaker.noticeCriteriaDTO.pageNum}">
                                        <input type="hidden" name="amount" value="${pageMaker.noticeCriteriaDTO.amount}">
                                        <input type="hidden" name="apartmentId" value="${apartment.apartmentId}">
                                        <c:if test="${not empty pageMaker.noticeCriteriaDTO.type}">
                                            <input type="hidden" name="type" value="${pageMaker.noticeCriteriaDTO.type}">
                                        </c:if>
                                        <c:if test="${not empty pageMaker.noticeCriteriaDTO.keyword}">
                                            <input type="hidden" name="keyword" value="${pageMaker.noticeCriteriaDTO.keyword}">
                                        </c:if>
                                    </form>
                                    
                                    <!-- 리뷰가 없는 경우 메시지 표시 -->
                                    <c:if test="${empty reviewList}">
                                        <div class="no-reviews">
                                            <div class="no-reviews-content">
                                                <div class="no-reviews-icon">
                                                    <i class="fas fa-comment-slash"></i>
                                                </div>
                                                <h3 class="no-reviews-title">아직 등록된 리뷰가 없습니다</h3>
                                                <p class="no-reviews-message">이 아파트에 대한 첫 번째 리뷰를 작성해보세요!</p>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 알림 모달 -->
    <div id="alertModal" class="modal">
        <div class="modal-content">
            <div id="modalIcon" class="modal-icon success">
                <i class="fas fa-check-circle"></i>
            </div>
            <h3 id="modalTitle" class="modal-title">알림</h3>
            <p id="modalMessage" class="modal-message"></p>
            <div class="modal-actions">
                <button id="modalButton" class="action-button primary-button" onclick="closeModal()">확인</button>
            </div>
        </div>
    </div>

    <!-- 삭제 확인 모달 -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <div class="modal-icon error">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            <h3 class="modal-title">아파트 삭제</h3>
            <p class="modal-message">정말로 이 아파트를 삭제하시겠습니까?</p>
            <div class="modal-actions">
                <button class="action-button secondary-button" onclick="closeDeleteModal()">취소</button>
                <button class="action-button danger-button" onclick="deleteApartment()">삭제</button>
            </div>
        </div>
    </div>
    
    <!-- 리뷰 삭제 확인 모달 -->
    <div id="deleteReviewModal" class="modal">
        <div class="modal-content">
            <div class="modal-icon error">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            <h3 class="modal-title">리뷰 삭제</h3>
            <p class="modal-message">정말로 이 리뷰를 삭제하시겠습니까?</p>
            <div class="modal-actions">
                <button class="action-button secondary-button" onclick="closeDeleteReviewModal()">취소</button>
                <button class="action-button danger-button" onclick="deleteReview()">삭제</button>
            </div>
        </div>
    </div>

    <!-- 폼 (AJAX 요청용) -->
    <form id="inquireForm" style="display: none;">
        <input type="hidden" name="apartmentId" id="inquireApartmentId" value="">
    </form>

    <form id="deleteForm" style="display: none;">
        <input type="hidden" name="apartmentId" id="deleteApartmentId" value="">
    </form>
    
    <input type="hidden" id="deleteReviewId" value="">

    <script>
        // JWT 토큰 관리 함수들
        function getJwtToken() {
            return localStorage.getItem('jwtToken');
        }

        function setJwtToken(token) {
            localStorage.setItem('jwtToken', token);
        }

        function removeJwtToken() {
            localStorage.removeItem('jwtToken');
        }


        function getCurrentUser() {
            const token = getJwtToken();
            if (!token) return null;
            
            try {
                const payload = JSON.parse(atob(token.split('.')[1]));
                return {
                    userNumber: payload.userNumber,
                    userName: payload.userName,
                    userAdmin: payload.userAdmin
                };
            } catch (e) {
                return null;
            }
        }

        // AJAX 요청에 JWT 토큰 헤더 추가
        function setupAjaxWithJWT() {
            $.ajaxSetup({
                beforeSend: function(xhr) {
                    const token = getJwtToken();
                    if (token) {
                        xhr.setRequestHeader('Authorization', 'Bearer ' + token);
                    }
                }
            });
        }

        // 페이지 로드 시 사용자 권한 확인
        $(document).ready(function() {
            setupAjaxWithJWT();
            checkUserPermissions();
            
            // 리뷰 수정/삭제 버튼 표시 여부 결정
            updateReviewActionButtons();
        });

        function checkUserPermissions() {
            const user = getCurrentUser();
            if (user && user.userAdmin === 1) {
                $('#adminMenuContainer').show();
            }
        }

        function updateReviewActionButtons() {
            const currentUser = getCurrentUser();
            if (!currentUser) return;

            $('.review-edit-delete').each(function() {
                const reviewUserNumber = parseInt($(this).data('user-number'));
                if (currentUser.userNumber === reviewUserNumber || currentUser.userAdmin === 1) {
                    $(this).show();
                }
            });
        }

        // 리뷰 수정 관련 JavaScript 코드
        $(document).ready(function() {
            // 리뷰 수정 버튼 클릭 이벤트
            $(document).on('click', '.review-action-icon.edit', function(e) {
                e.preventDefault();
				
				
                var reviewCard = $(this).closest('.review-card');
                var reviewId = reviewCard.find('.review-id-hidden').val();
                
                var reviewTitle = reviewCard.find('.review-title').text().trim();
                var reviewContent = reviewCard.find('.review-content p').text().trim();
                var reviewRating = reviewCard.find('.review-rating .fas.fa-star').length;
                
                reviewCard.data('originalTitle', reviewTitle);
                reviewCard.data('originalContent', reviewContent);
                reviewCard.data('originalRating', reviewRating);
                
                var titleInput = $('<input>').attr({
                    'type': 'text',
                    'class': 'edit-review-title',
                    'value': reviewTitle,
                    'placeholder': '리뷰 제목'
                });
                reviewCard.find('.review-title').empty().append(titleInput);
                
                var contentTextarea = $('<textarea>').attr({
                    'class': 'edit-review-content',
                    'placeholder': '리뷰 내용'
                }).text(reviewContent);
                reviewCard.find('.review-content').empty().append(contentTextarea);
                
                var ratingDiv = $('<div>').attr('class', 'edit-rating');
                var ratingInput = $('<input>').attr({
                    'type': 'hidden',
                    'id': 'edit-rating-value',
                    'value': reviewRating
                });
                
                for (var i = 1; i <= 5; i++) {
                    var starClass = (i <= reviewRating) ? 'fas fa-star' : 'far fa-star';
                    var star = $('<i>').attr({
                        'class': starClass + ' edit-star',
                        'data-value': i
                    });
                    ratingDiv.append(star);
                }
                
                reviewCard.find('.review-rating').empty().append(ratingDiv).append(ratingInput);
                
                reviewCard.find('.edit-star').on('click', function() {
                    var value = $(this).data('value');
                    
                    reviewCard.find('.edit-star').each(function(index) {
                        if (index < value) {
                            $(this).removeClass('far').addClass('fas');
                        } else {
                            $(this).removeClass('fas').addClass('far');
                        }
                    });
                    
                    reviewCard.find('#edit-rating-value').val(value);
                });
                
                var cancelButton = $('<button>').attr({
                    'type': 'button',
                    'class': 'action-button secondary-button cancel-edit'
                }).text('취소');
                
                var saveButton = $('<button>').attr({
                    'type': 'button',
                    'class': 'action-button primary-button save-edit',
                    'data-review-id': reviewId
                }).text('저장');
                
                var actionsDiv = $('<div>').attr('class', 'edit-actions')
                    .append(cancelButton)
                    .append(saveButton);
                
                reviewCard.find('.review-content').append(actionsDiv);
                reviewCard.addClass('editing');
            });
            
            // 취소 버튼 클릭 이벤트
            $(document).on('click', '.cancel-edit', function() {
                var reviewCard = $(this).closest('.review-card');
                
                var originalTitle = reviewCard.data('originalTitle');
                var originalContent = reviewCard.data('originalContent');
                var originalRating = reviewCard.data('originalRating');
                
                reviewCard.find('.review-title').html(originalTitle);
                reviewCard.find('.review-content').html('<p>' + originalContent + '</p>');
                
                var ratingHtml = '';
                for (var i = 1; i <= 5; i++) {
                    if (i <= originalRating) {
                        ratingHtml += '<i class="fas fa-star"></i>';
                    } else {
                        ratingHtml += '<i class="far fa-star"></i>';
                    }
                }
                reviewCard.find('.review-rating').html(ratingHtml);
                reviewCard.removeClass('editing');
            });
            
            // 저장 버튼 클릭 이벤트
            $(document).on('click', '.save-edit', function() {

                
                var reviewCard = $(this).closest('.review-card');
                var reviewId = $(this).data('review-id');
                
                var editedTitle = reviewCard.find('.edit-review-title').val();
                var editedContent = reviewCard.find('.edit-review-content').val();
                var editedRating = parseInt(reviewCard.find('#edit-rating-value').val());
                
                if (!editedTitle || !editedTitle.trim()) {
                    alert('리뷰 제목을 입력해주세요.');
                    return;
                }
                
                if (!editedContent || !editedContent.trim()) {
                    alert('리뷰 내용을 입력해주세요.');
                    return;
                }
                
                if (isNaN(editedRating) || editedRating < 1 || editedRating > 5) {
                    alert('유효한 별점을 선택해주세요.');
                    return;
                }
                
                $.ajax({
                    type: "post",
                    url: "updateReview",
                    data: {
                        reviewId: reviewId,
                        reviewTitle: editedTitle,
                        reviewContent: editedContent,
                        reviewRating: editedRating,
                        apartmentId: $('input[name="apartmentId"]').val()
                    },
                    success: function(response) {
                        if (response.success) {
                            reviewCard.find('.review-title').html(editedTitle);
                            reviewCard.find('.review-content').html('<p>' + editedContent + '</p>');
                            
                            var ratingHtml = '';
                            for (var i = 1; i <= 5; i++) {
                                if (i <= editedRating) {
                                    ratingHtml += '<i class="fas fa-star"></i>';
                                } else {
                                    ratingHtml += '<i class="far fa-star"></i>';
                                }
                            }
                            reviewCard.find('.review-rating').html(ratingHtml);
                            reviewCard.removeClass('editing');
                            
                            showModal('success', '리뷰 수정 완료', '리뷰가 성공적으로 수정되었습니다.');
                        } else {
                            showModal('error', '수정 실패', response.message || '리뷰 수정에 실패했습니다.');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("AJAX 오류:", status, error);
                        
                        var errorMessage = '리뷰 수정 중 오류가 발생했습니다.';
                        try {
                            var response = JSON.parse(xhr.responseText);
                            if (response.message) {
                                errorMessage = response.message;
                            }
                        } catch (e) {
                            console.error('JSON 파싱 오류:', e);
                        }
                        
                        showModal('error', '오류 발생', errorMessage);
                    }
                });
            });
        });

        // 페이징처리
        var actionForm = $("#actionForm");

        $(".paginate_button a").on("click", function (e) {
            e.preventDefault();
            
            const pageNum = $(this).attr("href");
            sessionStorage.setItem("activeTab", "reviews");
            
            actionForm.find("input[name='pageNum']").val(pageNum);
            
            $.ajax({
                type: "get",
                url: "apartment_detail",
                data: actionForm.serialize(),
                success: function(response) {
                    const reviewsHtml = $(response).find('.reviews-list').html();
                    const paginationHtml = $(response).find('.div_page').html();
                    
                    $('.reviews-list').html(reviewsHtml);
                    $('.div_page').html(paginationHtml);
                    
                    bindPaginationEvents();
                    updateReviewActionButtons();
                    
                    $('.paginate_button').removeClass('active');
                    $(`.paginate_button a[href="${pageNum}"]`).parent().addClass('active');
                },
                error: function() {
                    showModal('error', '오류 발생', '페이지 로드 중 오류가 발생했습니다.');
                }
            });
        });

        function bindPaginationEvents() {
            $(".paginate_button a").off("click").on("click", function (e) {
                e.preventDefault();
                
                const pageNum = $(this).attr("href");
                sessionStorage.setItem("activeTab", "reviews");
                
                actionForm.find("input[name='pageNum']").val(pageNum);
                
                $.ajax({
                    type: "get",
                    url: "apartment_detail",
                    data: actionForm.serialize(),
                    success: function(response) {
                        const reviewsHtml = $(response).find('.reviews-list').html();
                        const paginationHtml = $(response).find('.div_page').html();
                        
                        $('.reviews-list').html(reviewsHtml);
                        $('.div_page').html(paginationHtml);
                        
                        bindPaginationEvents();
                        updateReviewActionButtons();
                        updateHelpfulButtonsUI();
                        
                        $('.paginate_button').removeClass('active');
                        $(`.paginate_button a[href="${pageNum}"]`).parent().addClass('active');
                    },
                    error: function() {
                        showModal('error', '오류 발생', '페이지 로드 중 오류가 발생했습니다.');
                    }
                });
            });
        }

        function updateHelpfulButtonsUI() {
            $('.review-card').each(function() {
                const likeButton = $(this).find('.review-action-icon.like');
                
                if (likeButton.hasClass('active')) {
                    likeButton.removeClass('far').addClass('fas');
                } else {
                    likeButton.removeClass('fas').addClass('far');
                }
            });
        }

        function markHelpful(reviewId, element) {

            
            const isActive = $(element).hasClass('active');
            
            $.ajax({
                type: "post",
                url: isActive ? "review_unhelpful" : "review_helpful",
                data: { reviewId: reviewId },
                success: function(response) {
                    if (response.success) {
                        if (isActive) {
                            $(element).removeClass('active fas').addClass('far');
                        } else {
                            $(element).removeClass('far').addClass('fas active');
                        }
                        
                        const helpfulCountElement = $(element).closest('.helpful-container').find('.helpful-count');
                        if (helpfulCountElement.length > 0) {
                            helpfulCountElement.text(response.helpfulCount);
                        }
                        
                        saveHelpfulState(reviewId, !isActive);
                    } else {
                        showModal('error', '오류 발생', response.message || '도움됨 처리 중 오류가 발생했습니다.');
                    }
                },
                error: function(xhr) {
                    let errorMessage = '서버 통신 중 오류가 발생했습니다.';
                    try {
                        const response = JSON.parse(xhr.responseText);
                        if (response.message) {
                            errorMessage = response.message;
                        }
                    } catch (e) {
                        console.error('JSON 파싱 오류:', e);
                    }
                    showModal('error', '오류 발생', errorMessage);
                }
            });
        }

        function saveHelpfulState(reviewId, isHelpful) {
            const currentUser = getCurrentUser();
            if (!currentUser) return;
            
            const userNumber = currentUser.userNumber;
            const storageKey = `helpful_${userNumber}`;
            
            let helpfulData = JSON.parse(localStorage.getItem(storageKey) || '{}');
            helpfulData[reviewId] = isHelpful;
            
            localStorage.setItem(storageKey, JSON.stringify(helpfulData));
        }

        function restoreHelpfulState() {
            const currentUser = getCurrentUser();
            if (!currentUser) return;
            
            const userNumber = currentUser.userNumber;
            const storageKey = `helpful_${userNumber}`;
            
            const helpfulData = JSON.parse(localStorage.getItem(storageKey) || '{}');
            
            $('.review-card').each(function() {
                const reviewId = $(this).find('.review-id-hidden').val();
                const likeButton = $(this).find('.review-action-icon.like');
                
                if (likeButton.hasClass('active')) {
                    likeButton.removeClass('far').addClass('fas');
                } else if (helpfulData[reviewId]) {
                    likeButton.addClass('active');
                    likeButton.removeClass('far').addClass('fas');
                }
            });
        }

        $(document).ready(function() {
            bindPaginationEvents();
            
            const currentPage = actionForm.find("input[name='pageNum']").val();
            
            if (currentPage) {
                $('.paginate_button').each(function() {
                    const link = $(this).find('a');
                    if (link.length && link.attr('href') === currentPage) {
                        $(this).addClass('active');
                    }
                });
            }
            
            updateHelpfulButtonsUI();
            restoreHelpfulState();
        });
        
        // 페이지 로드 시 탭 상태 복원
        document.addEventListener('DOMContentLoaded', function() {
            const activeTab = sessionStorage.getItem("activeTab");
            if (activeTab === "reviews") {
                document.querySelectorAll('.tab-item').forEach(tab => {
                    tab.classList.remove('active');
                    if (tab.dataset.tab === 'reviews') {
                        tab.classList.add('active');
                    }
                });
                
                document.querySelectorAll('.tab-panel').forEach(panel => {
                    panel.classList.remove('active');
                    if (panel.id === 'reviews') {
                        panel.classList.add('active');
                    }
                });
                
                sessionStorage.removeItem("activeTab");
            }
        });
        
        // 탭 기능
        document.querySelectorAll('.tab-item').forEach(tab => {
            tab.addEventListener('click', () => {
                document.querySelectorAll('.tab-item').forEach(t => t.classList.remove('active'));
                tab.classList.add('active');
                
                document.querySelectorAll('.tab-panel').forEach(panel => panel.classList.remove('active'));
                document.getElementById(tab.dataset.tab).classList.add('active');
                
                sessionStorage.removeItem("activeTab");
            });
        });

        // 관리자 햄버거 메뉴 토글
        function toggleAdminMenu() {
            const dropdown = document.getElementById('adminMenuDropdown');
            if (dropdown.style.display === 'block') {
                dropdown.style.display = 'none';
            } else {
                dropdown.style.display = 'block';
                document.addEventListener('click', closeMenuOnClickOutside);
            }
        }
        
        function closeMenuOnClickOutside(event) {
            const dropdown = document.getElementById('adminMenuDropdown');
            const button = document.querySelector('.admin-menu-button');
            
            if (!dropdown.contains(event.target) && !button.contains(event.target)) {
                dropdown.style.display = 'none';
                document.removeEventListener('click', closeMenuOnClickOutside);
            }
        }

        // 별점 선택 기능
        document.querySelectorAll('.rating-input i').forEach(star => {
            star.addEventListener('click', () => {
                const rating = parseInt(star.dataset.rating);
                document.getElementById('ratingInput').value = rating;
                
                document.querySelectorAll('.rating-input i').forEach((s, index) => {
                    if (index < rating) {
                        s.className = 'fas fa-star';
                    } else {
                        s.className = 'far fa-star';
                    }
                });
            });
            
            star.addEventListener('mouseenter', () => {
                const rating = parseInt(star.dataset.rating);
                
                document.querySelectorAll('.rating-input i').forEach((s, index) => {
                    if (index < rating) {
                        s.className = 'fas fa-star';
                    } else {
                        s.className = 'far fa-star';
                    }
                });
            });
            
            star.addEventListener('mouseleave', () => {
                const currentRating = parseInt(document.getElementById('ratingInput').value);
                
                document.querySelectorAll('.rating-input i').forEach((s, index) => {
                    if (index < currentRating) {
                        s.className = 'fas fa-star';
                    } else {
                        s.className = 'far fa-star';
                    }
                });
            });
        });

        // 리뷰 폼 초기화
        function resetReviewForm() {
            document.getElementById('reviewForm').reset();
            document.getElementById('ratingInput').value = 0;
            document.getElementById('reviewId').value = '';
            document.querySelectorAll('.rating-input i').forEach(star => {
                star.className = 'far fa-star';
            });
            document.querySelector('.form-title').textContent = '리뷰 작성하기';
            document.querySelector('.form-actions button.primary-button').textContent = '리뷰 등록';
        }

        // 리뷰 제출
        function submitReview() {

            
            const reviewId = document.getElementById('reviewId').value;
            const apartmentId = document.getElementById('apartmentIdInput').value;
            const rating = document.getElementById('ratingInput').value;
            const title = document.getElementById('reviewTitle').value;
            const content = document.getElementById('reviewContent').value;
            
            if (rating === '0') {
                showModal('error', '평점 필요', '리뷰를 등록하려면 평점을 선택해주세요.');
                return;
            }
            
            const url = reviewId ? "updateReview" : "insertReview";
            
            $.ajax({
                type: "post",
                url: url,
                data: {
                    reviewId: reviewId,
                    apartmentId: apartmentId,
                    reviewRating: rating,
                    reviewTitle: title,
                    reviewContent: content
                },
                success: function(response) {
                    if (response.success) {
                        showModal('success', reviewId ? '리뷰 수정 완료' : '리뷰 등록 완료', response.message);
                        resetReviewForm();
                        
                        setTimeout(function() {
                            sessionStorage.setItem("activeTab", "reviews");
                            location.reload();
                        }, 1500);
                    } else {
                        showModal('error', '오류 발생', response.message || '처리 중 오류가 발생했습니다.');
                    }
                },
                error: function(xhr, status, error) {
                    console.error("AJAX 오류:", status, error);
                    
                    let errorMessage = '서버 통신 중 오류가 발생했습니다.';
                    
                    try {
                        if (xhr.responseJSON && xhr.responseJSON.message) {
                            errorMessage = xhr.responseJSON.message;
                        } else if (xhr.responseText) {
                            try {
                                const response = JSON.parse(xhr.responseText);
                                if (response.message) {
                                    errorMessage = response.message;
                                }
                            } catch (e) {
                                console.error("JSON 파싱 오류:", e);
                            }
                        }
                    } catch (e) {
                        console.error("응답 처리 오류:", e);
                    }
                    
                    showModal('error', '오류 발생', errorMessage);
                }
            });
        }

        // 리뷰 삭제 확인 모달 표시
        function confirmDeleteReview(reviewId) {

            
            document.getElementById('deleteReviewId').value = reviewId;
            document.getElementById('deleteReviewModal').classList.add('show');
        }

        // 리뷰 삭제 실행
        function deleteReview() {
            const reviewId = document.getElementById('deleteReviewId').value;
            
            $.ajax({
                type: "post",
                url: "deleteReview",
                data: { reviewId: reviewId },
                success: function(response) {
                    if (response.success) {
                        showModal('success', '삭제 완료', '리뷰가 성공적으로 삭제되었습니다.');
                        setTimeout(() => {
                            sessionStorage.setItem("activeTab", "reviews");
                            location.reload();
                        }, 1500);
                    } else {
                        showModal('error', '삭제 실패', response.message || '리뷰 삭제에 실패했습니다.');
                    }
                },
                error: function() {
                    showModal('error', '오류 발생', '서버 통신 중 오류가 발생했습니다.');
                }
            });
            
            closeDeleteReviewModal();
        }

        // 리뷰 삭제 모달 닫기
        function closeDeleteReviewModal() {
            document.getElementById('deleteReviewModal').classList.remove('show');
        }

        // 아파트 문의하기
        function inquireApartment(apartmentId) {

            
            document.getElementById('inquireApartmentId').value = apartmentId;
            
            $.ajax({
                type: "post",
                url: "apartment_inquiry",
                data: $("#inquireForm").serialize(),
                success: function(response) {
                    if (response.success) {
                        showModal('success', '문의 완료', '아파트 문의가 성공적으로 접수되었습니다!');
                    } else {
                        showModal('error', '오류 발생', response.message || '문의 접수 중 오류가 발생했습니다.');
                    }
                },
                error: function(xhr) {
                    let errorMessage = '서버 통신 중 오류가 발생했습니다.';
                    try {
                        const response = JSON.parse(xhr.responseText);
                        if (response.message) {
                            errorMessage = response.message;
                        }
                    } catch (e) {
                        console.error('JSON 파싱 오류:', e);
                    }
                    showModal('error', '오류 발생', errorMessage);
                }
            });
        }

        // 관심목록에 추가
        function addToFavorites(apartmentId) {

            
			$.ajax({
			    url: '/favorite/insert',
			    type: 'POST',
			    contentType: 'application/json',
			    data: JSON.stringify({
			        lat: lat,
			        lng: lng,
			        dealAmount: dealAmount
			    }),
			    xhrFields: {
			        withCredentials: true  // 쿠키를 함께 전송
			    },
			    success: function () {
			        alert('관심목록에 등록되었습니다.');
					location.reload()
			    },
			    error: function () {
			        alert('관심등록 실패!');
			    }
			});
        }

        // 아파트 삭제 확인
        function confirmDelete(apartmentId) {

            
            const currentUser = getCurrentUser();
            if (!currentUser || currentUser.userAdmin !== 1) {
                showModal('error', '권한 없음', '관리자만 삭제할 수 있습니다.');
                return;
            }
            
            document.getElementById('deleteApartmentId').value = apartmentId;
            document.getElementById('deleteModal').classList.add('show');
        }

        // 아파트 삭제 실행
        function deleteApartment() {
            $.ajax({
                type: "post",
                url: "apartment_delete",
                data: $("#deleteForm").serialize(),
                success: function(response) {
                    if (response.success) {
                        showModal('success', '삭제 완료', '아파트가 성공적으로 삭제되었습니다.');
                        setTimeout(function() {
                            location.href = "apartment_search_view";
                        }, 1500);
                    } else {
                        showModal('error', '삭제 실패', response.message || '아파트 삭제에 실패했습니다.');
                    }
                },
                error: function(xhr) {
                    showModal('error', '오류 발생', '서버 오류가 발생했습니다.');
                }
            });
            closeDeleteModal();
        }

        // 모달 표시
        function showModal(type, title, message) {
            const modal = document.getElementById('alertModal');
            const icon = document.getElementById('modalIcon');
            const iconElement = icon.querySelector('i');
            
            document.getElementById('modalTitle').textContent = title;
            document.getElementById('modalMessage').textContent = message;
            
            if (type === 'success') {
                icon.className = 'modal-icon success';
                iconElement.className = 'fas fa-check-circle';
            } else if (type === 'info') {
                icon.className = 'modal-icon info';
                iconElement.className = 'fas fa-info-circle';
            } else {
                icon.className = 'modal-icon error';
                iconElement.className = 'fas fa-exclamation-circle';
            }
            
            modal.classList.add('show');
        }

        // 모달 닫기
        function closeModal() {
            document.getElementById('alertModal').classList.remove('show');
            
            if (document.getElementById('modalIcon').classList.contains('success')) {
                location.reload();
            }
        }

        // 삭제 모달 닫기
        function closeDeleteModal() {
            document.getElementById('deleteModal').classList.remove('show');
        }

        // 페이지 로드 시 알림 처리
        document.addEventListener('DOMContentLoaded', function() {
            // 서버에서 전달된 메시지 처리 (필요시)
            const urlParams = new URLSearchParams(window.location.search);
            const errorMsg = urlParams.get('errorMsg');
            const successMsg = urlParams.get('successMsg');
            
            if (errorMsg) {
                showModal('error', '오류 발생', errorMsg);
            }
            
            if (successMsg) {
                showModal('success', '완료', successMsg);
            }
        });
    </script>
</body>
</html>
