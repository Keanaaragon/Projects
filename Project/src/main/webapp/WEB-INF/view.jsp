<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page isErrorPage="true" %>
       <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="/css/Style.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" 
integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" 
integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" 
integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<title>The Wine</title>
</head>
<body>
	<div class="container">
		<div class="view">
			<h4>Type:</h4><p>${wine.type}</p>
			<h4>Winery:</h4><p>${wine.winery}</p>
			<h4>Vintage:</h4><p>${wine.vintage}</p>
		</div>
	    <a href="/wines"><button type="submit" >Go Back</button></a>
	    <a href="/wines/${item_id}/delete"><button type="submit" >Delete wine</button></a>
	    <a href="/wines/${item_id}/edit"><button type="submit" >edit wine</button></a>
    </div>
    <div class="container text-center">
    	<h1>${wine.name}</h1>
	<img style="width:400px; height:300px; vertical-align:center;" alt="img" src="/imgs/${wine.id}.jpg">
    </div>
    <div class="container">
    <h1>Reviews</h1>
	<table class="table">
		  <thead class="thead-dark">
		    <tr>
		      <th scope="col">User ID</th>
		      <th scope="col">Appearance</th>
		      <th scope="col">Aroma</th>
		      <th scope="col">Taste</th>
		      <th scope="col">Rate</th>
		      <th scope="col">Comment</th>
		    </tr>
		  </thead>
		  <tbody>
	<c:forEach items="${Review}" var="review" >	
	<c:if test="${review.wine == wine}"> 
		    <tr>
		      <th scope="row">${review.user.id}</th>
		      <td>${review.appearance}</td>
		      <td>${review.aroma}</td>
		      <td>${review.taste}</td>
		      <td>${review.rate}</td>
		      <td>${review.comment}</td>
		      <ln>
		    </tr>
	</c:if> 	    
    </c:forEach>
		  </tbody>
		</table>    
    
 <a href="/review/new/${item_id}"><button type="button">Add Review</button></a>
    </div>
</body>
</html>