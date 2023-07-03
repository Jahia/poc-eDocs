<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="content" value="${currentNode.properties['doc4:content'].string}"/>
<c:set var="title" value="${currentNode.displayableName}"/>
<h2>${title}</h2>
${content}