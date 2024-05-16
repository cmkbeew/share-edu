<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<nav aria-label="Page navigation example">
    <ul class="pagination" style="justify-content: center">
        <li class="page-item <c:if test="${responseDTO.prev_page_flag ne true}">disabled</c:if> ">
            <a class="page-link"
               href="<c:choose>
                            <c:when test="${responseDTO.prev_page_flag}">
                                ${responseDTO.linkParams}&page=${responseDTO.page_block_start - 1}
                            </c:when>
                            <c:otherwise>
                                ${responseDTO.linkParams}&page=1
                            </c:otherwise>
                        </c:choose>"
               aria-label="Previous"
               data-num="<c:choose>
                                <c:when test="${responseDTO.prev_page_flag}">
                                    ${responseDTO.page_block_start - 1}
                                </c:when>
                                <c:otherwise>
                                    1
                                </c:otherwise>
                            </c:choose>"
            >
                <span aria-hidden="true">&laquo;</span>
            </a>
        </li>

        <c:forEach begin="${responseDTO.page_block_start}" end="${responseDTO.page_block_end}" var="page_num">
            <li class="page-item <c:if test="${responseDTO.page == page_num}">active</c:if>" >
                <a class="page-link" data-num="${page_num}"
                   href="<c:choose>
                                <c:when test="${responseDTO.page == page_num}">#</c:when>
                                <c:otherwise>
                                    ${responseDTO.linkParams}&page=${page_num}
                                </c:otherwise>
                            </c:choose>">
                        ${page_num}
                </a>
            </li>
        </c:forEach>

        <li class="page-item <c:if test="${responseDTO.next_page_flag ne true}">disabled</c:if>" >
            <a class="page-link"
               href="<c:choose>
                            <c:when test="${responseDTO.next_page_flag}">
                                ${responseDTO.linkParams}&page=${responseDTO.page_block_end + 1}
                            </c:when>
                            <c:otherwise>
                                ${responseDTO.page_block_end}
                            </c:otherwise>
                        </c:choose>"
               aria-label="Next"
               data-num="<c:choose>
                                 <c:when test="${responseDTO.next_page_flag}">
                                    ${responseDTO.page_block_end + 1}
                                 </c:when>
                                 <c:otherwise>
                                    ${responseDTO.page_block_end}
                                 </c:otherwise>
                             </c:choose>">
                <span aria-hidden="true">&raquo;</span>
            </a>
        </li>
    </ul>
</nav>
