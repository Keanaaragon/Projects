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
<title>Create A Wine</title>
<style>

</style>
</head>
<body>
	<div class="container">
	 	<h1>Create A Wine</h1>
	    
	    <p><form:errors path="wine.*"/></p>
	    
	    <form:form method="POST" action="/wines/new" modelAttribute="wine">
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
	        <button type="submit">Create</button>
	    </form:form>  
	    <button type="submit"><a href="/wines">Go Back</a></button>
    </div>
    
</body>
</html>