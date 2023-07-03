<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="random" class="java.util.Random" scope="application" />



<template:addResources type="css" resources="webapp/${requestScope.webappCssFileName}" media="screen"/>
<%--<link rel="stylesheet" src="/modules/gp-poc-documents/css/webapp/main.a6276781.css" media="all"/>--%>
<script type="application/javascript" src="/modules/gp-poc-documents/javascript/webapp/${requestScope.webappJsFileName}"></script>
<%--<template:addResources type="javascript" resources="webapp/${requestScope.webappJsFileName}" media="screen"/>--%>
<%-- Doesn't work in CE preview --%>

<c:set var="workspace" value="${renderContext.workspace}"/>
<c:set var="host" value="${url.server}"/>
<c:set var="_uuid_" value="${currentNode.identifier}"/>

<c:set var="language" value="${currentResource.locale.language}"/>
<c:set var="targetId" value="REACT_DOCUMENT_RENDERER_${fn:replace(random.nextInt(),'-','_')}"/>

<!-- CM view -->
<div id="${targetId}"></div>
<script>
    console.log("jsp window :",window)
    window.pocDocumentReact("${targetId}",{
        workspace:"${renderContext.liveMode ? 'LIVE' : 'EDIT'}",
        locale:"${language}",
        gqlEndpoint:"${host}/modules/graphql",
        documentId:"${_uuid_}",
        host:"${host}"
    });
</script>


