<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div>
									<c:if test="${paging.prev}">
										<c:set var="prevPage" value="${paging.startNum-1}" />
										<a data-page="${prevPage}" class="pageClass">이전</a>
									</c:if>

									<c:forEach begin="${paging.startNum}"
										end="${paging.startNum+9 > paging.lastNum ? paging.lastNum : paging.startNum+9}"
										var="page">
										<%-- <c:if test="${page ne paging.pageNum}"> --%>
											<a class="pageClass" data-page="${page}">${page}</a>
										<%-- </c:if> --%>
									</c:forEach>

									<c:if test="${paging.next}">
										<c:set var="nextPage" value="${paging.startNum+10}" />
										<a class="pageClass" data-page="${nextPage}">다음</a>
									</c:if>
</div>