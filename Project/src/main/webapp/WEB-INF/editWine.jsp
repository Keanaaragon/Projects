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
<title>Edit A Wine</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" 
integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" 
integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" 
integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
</head>
<body>
	<div class="container">
	 	<h1>Edit Wine!</h1>
	    
	    <p><form:errors path="wine.*"/></p>
	    
	    <form:form method="POST" action="/wines/${item_id}/edit" modelAttribute="wine">
		 <p>
		        <form:label path="type">Type:</form:label>
		        <form:input type="text" path="type"/>
		    </p>
	        <p>
	            <form:label path="name">Name:</form:label>
	            <form:input type="text" path="name"/>
	        </p>
	             <p>
	            <form:label path="winery">Winery:</form:label>
	            <form:input type="text" path="winery"/>
	        </p>
	             <p>
	            <form:label path="vintage">Vintage:</form:label>
	            <form:input type="number" path="vintage"/>
	        </p>
	        	
	        <button type="submit" class="btn-btn-success">Update</button>
	    </form:form>
	    <a href="/wines/${item_id}/delete">Delete wine</a>
    </div>
    
</body>
</html>