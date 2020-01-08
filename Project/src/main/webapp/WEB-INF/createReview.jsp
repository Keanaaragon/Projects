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
<title>Create A Review</title>
<style>

</style>
</head>
<body>
	<div class="container">
	 	<h1>Create A Review</h1>
	    
	    <p><form:errors path="review.*"/></p>
	    
	    <form:form method="POST" action="/review/new/${item.id}" modelAttribute="review">
		 <p>
		        <form:label path="appearance">Appearance:</form:label>
		        <form:input type="text" path="appearance"/>
		    </p>
	        <p>
	            <form:label path="aroma">Aroma:</form:label>
	            <form:input type="text" path="aroma"/>
	        </p>
	             <p>
	            <form:label path="taste">Taste:</form:label>
	            <form:input type="text" path="taste"/>
	        </p>
	             <p>
	            <form:label path="rate">Rate:</form:label>
	            <form:input type="number" path="rate"/>
	        </p>
	        	<p>
	            <form:label path="comment">Comment:</form:label>
	            <form:input type="textera" path="comment"/>
	        </p>
	        <button type="submit">Create</button>
	    </form:form>  
	    <button type="submit"><a href="/wines/${item.id}">Go Back</a></button>
    </div>
    
</body>
</html>