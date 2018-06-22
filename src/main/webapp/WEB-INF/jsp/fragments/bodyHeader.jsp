<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<spring:url value="/resources/images/banner-graphic.png" var="banner"/>
<img src="${banner}" style="width: 695px;" />

<nav class="navbar navbar-default" style="width: 695px;">
  <div class="container-fluid">
   <div class="navbar-header">
    <button type="button" class="collapsed navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-7" aria-expanded="false"> <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
    <a href="#" class="navbar-brand">Credit Cards</a>
  </div>
  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-7">
    <ul class="nav navbar-nav">
      <li><a href="<spring:url value="/" htmlEscape="true" />">Home</a></li>
      <li><a href="<spring:url value="/owners/find.html" htmlEscape="true"/>"></i>Find owners</a></li>
      <li><a href="<spring:url value="/oups.html" htmlEscape="true" />" title="trigger a RuntimeException to see how it is handled"></i> Error</a></li>
    </ul>
  </div>
</div>
</nav>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	
