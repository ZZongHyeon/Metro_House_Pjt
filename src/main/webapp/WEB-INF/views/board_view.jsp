<%@page import="com.boot.dto.UserDTO"%>
<%@page import="com.boot.dto.BoardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>커뮤니티 게시판 - 메트로하우스</title>
    <link rel="stylesheet" type="text/css" href="/resources/css/board_view.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="/resources/js/board_view.js"></script>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container">
        <div class="board-container">
            <div class="board-header">
                <h1 class="board-title"><i class="fas fa-comments"></i> 커뮤니티 게시판</h1>
                <div class="board-actions">
                    <% 
                    UserDTO user = (UserDTO) session.getAttribute("loginUser");
                    if (user != null) { 
                    %>
                    <button class="write-button" onclick="location.href='/board_write'">
                        <i class="fas fa-pen"></i> 글쓰기
                    </button>
                    <% } %>
                </div>
            </div>
            
<!--            <div class="board-info-banner">-->
<!--                <div class="info-item">-->
<!--                    <i class="fas fa-clipboard-list"></i>-->
<!--                    <span>총 게시글 <strong>${totalPosts}</strong>개</span>-->
<!--                </div>-->
<!--                <div class="info-item">-->
<!--                    <i class="fas fa-eye"></i>-->
<!--                    <span>전체 조회 <strong>${totalViews}</strong>회</span>-->
<!--                </div>-->
<!--                <div class="info-item">-->
<!--                    <i class="fas fa-thumbs-up"></i>-->
<!--                    <span>전체 추천 <strong>${totalLikes}</strong>개</span>-->
<!--                </div>-->
<!--            </div>-->
            
            <div class="sort-options">
                <div class="sort-option ${param.sort == 'latest' || param.sort == null ? 'active' : ''}" onclick="changeSort('latest')">최신순</div>
                <div class="sort-option ${param.sort == 'views' ? 'active' : ''}" onclick="changeSort('views')">조회순</div>
                <div class="sort-option ${param.sort == 'likes' ? 'active' : ''}" onclick="changeSort('likes')">추천순</div>
            </div>
            
            <form class="search-form" action="/board_view" method="get">
                <select name="searchType" class="search-select">
                    <option value="title" ${param.searchType == 'title' ? 'selected' : ''}>제목</option>
                    <option value="content" ${param.searchType == 'content' ? 'selected' : ''}>내용</option>
                    <option value="author" ${param.searchType == 'author' ? 'selected' : ''}>작성자</option>
                </select>
                <input type="text" name="keyword" class="search-input" placeholder="검색어를 입력하세요" value="${param.keyword}">
                <button type="submit" class="search-button">
                    <i class="fas fa-search"></i>
                </button>
            </form>
            
            <div class="table-container">
                <table class="board-table">
                    <thead>
                        <tr>
                            <th class="board-number">번호</th>
                            <th class="board-title-col">제목</th>
                            <th class="board-author">작성자</th>
                            <th class="board-date">작성일</th>
                            <th class="board-views">조회</th>
                            <th class="board-likes">추천</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty boardList}">
                            <tr>
                                <td colspan="6" class="empty-message">등록된 게시글이 없습니다.</td>
                            </tr>
                        </c:if>
                        
                        <c:forEach items="${boardList}" var="board" varStatus="status">
                            <tr>
                                <td class="board-number">${status.count}</td>
                                <td class="board-title-col">
                                    <a href="board_detail_view?boardNumber=${board.boardNumber}" class="title-link">
                                        ${board.boardTitle}
                                        <c:if test="${board.commentCount > 0}">
                                            <span class="comment-count">[${board.commentCount}]</span>
                                        </c:if>
                                    </a>
                                </td>
                                <td class="board-author">${board.userName}</td>
								<td class="board-date">
								    <c:set var="dateStr" value="${board.boardWriteDate}" />
								    <c:if test="${not empty dateStr}">
								        <c:choose>
								            <c:when test="${fn:length(dateStr) > 10}">
								                ${fn:substring(dateStr, 0, 10)}
								            </c:when>
								            <c:otherwise>
								                ${dateStr}
								            </c:otherwise>
								        </c:choose>
								    </c:if>
								</td>
                                <td class="board-views">${board.boardViews}</td>
                                <td class="board-likes">${board.boardLikes}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <div class="page-item">
                        <a href="/board_view?page=${currentPage - 1}${not empty param.searchType ? '&searchType='.concat(param.searchType) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}${not empty param.sort ? '&sort='.concat(param.sort) : ''}" class="page-link">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                    </div>
                </c:if>
                
                <c:forEach begin="1" end="${totalPages}" var="pageNum">
                    <div class="page-item ${pageNum == currentPage ? 'active' : ''}">
                        <a href="/board_view?page=${pageNum}${not empty param.searchType ? '&searchType='.concat(param.searchType) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}${not empty param.sort ? '&sort='.concat(param.sort) : ''}" class="page-link">${pageNum}</a>
                    </div>
                </c:forEach>
                
                <c:if test="${currentPage < totalPages}">
                    <div class="page-item">
                        <a href="/board_view?page=${currentPage + 1}${not empty param.searchType ? '&searchType='.concat(param.searchType) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}${not empty param.sort ? '&sort='.concat(param.sort) : ''}" class="page-link">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <script>
        function changeSort(sortType) {
            // 정렬 옵션 변경 시 처리
            const sortOptions = document.querySelectorAll('.sort-option');
            sortOptions.forEach(option => {
                option.classList.remove('active');
            });
            
            event.target.classList.add('active');
            
            // 검색 파라미터 유지하면서 정렬 변경
            const currentUrl = new URL(window.location.href);
            const searchParams = currentUrl.searchParams;
            
            // 기존 검색 파라미터 유지
            let url = '/board_view?sort=' + sortType;
            
            if(searchParams.has('searchType') && searchParams.has('keyword')) {
                url += '&searchType=' + searchParams.get('searchType') + '&keyword=' + searchParams.get('keyword');
            }
            
            if(searchParams.has('page')) {
                url += '&page=' + searchParams.get('page');
            }
            
            location.href = url;
        }
    </script>
</body>
</html>