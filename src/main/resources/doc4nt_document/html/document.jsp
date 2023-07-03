<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="random" class="java.util.Random" scope="application" />

<template:addResources type="css" resources="webapp/${requestScope.webappCssFileName}" media="screen"/>
<template:addResources type="javascript" resources="webapp/${requestScope.webappJsFileName}" />

<c:set var="workspace" value="${renderContext.workspace}"/>
<c:set var="host" value="${url.server}"/>
<c:set var="_uuid_" value="${currentNode.identifier}"/>
<c:set var="language" value="${currentResource.locale.language}"/>
<c:set var="targetId" value="REACT_DOCUMENT_RENDERER_${fn:replace(random.nextInt(),'-','_')}"/>


<div id="${targetId}"></div>
<script>
    const documentRenderer_context_${targetId}={
        workspace:"${renderContext.liveMode ? 'LIVE' : 'EDIT'}",
        locale:"${language}",
        gqlEndpoint:"${host}/modules/graphql",
        documentId:"${_uuid_}",
        host:"${host}"
    }
    window.addEventListener("DOMContentLoaded", (event) => {
        <%--//in case if edit mode slow down the load waiting for the jahia GWT UI was setup,--%>
        <%--// otherwise the react app failed (maybe loosing his position as the DOM is updated by the jahia UI at the same time)--%>
        <c:choose>
        <c:when test="${renderContext.editMode}" >
        setTimeout(() => {
            window.pocDocumentReact("${targetId}",documentRenderer_context_${targetId});
        },500);
        </c:when>
        <c:otherwise>
        window.pocDocumentReact("${targetId}",documentRenderer_context_${targetId});
        </c:otherwise>
        </c:choose>
    });
</script>

