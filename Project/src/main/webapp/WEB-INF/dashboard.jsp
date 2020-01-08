<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page isErrorPage="true" %>
       <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>All the Wines</title>
<link rel="stylesheet" href="/css/Style.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" 
integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" 
integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" 
integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</head>
<body>
<div class="jumbotron text-center conatiner-fluid">
	<h1 style="font-family:URW Chancery L, cursive">Welcome to Wine'ers!</h1>
	<h2>Join the fun and "wine" about the latest vino on your mind!</h2>
</div>
 
 
 
 
  
  
  <div class="jumbotron bd-example">
  <div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
    <ol class="carousel-indicators">
      <li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
      <li data-target="#carouselExampleCaptions" data-slide-to="1" ></li>
      <li data-target="#carouselExampleCaptions" data-slide-to="2" ></li>
    </ol>
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img src="/imgs/vineyard.jpg" class="d-block w-100" alt="vineyard">
        <div class="carousel-caption d-none d-md-block">
          <h5>White Wine Lovers Unite!</h5>
          <p>Come and review these two amazing bottles of white wines!</p>
        </div>
      </div>
      <div class="carousel-item">
        <img src="/imgs/b.JPG" class="d-block w-100" alt="b">
        <div class="carousel-caption d-none d-md-block">
          <h5>Rose and Red!</h5>
          <p>Prefer a Rose? Well then come share your passion with us!</p>
        </div>
      </div>
      <div class="carousel-item">
        <img src="/imgs/WnR.jpg" class="d-block w-100" alt="WnR">
        <div class="carousel-caption d-none d-md-block">
          <h5>Bold Red</h5>
          <p>Darkest desires of red house blends? We got you covered! </p>
        </div>
      </div>
    </div>
    <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
</div>
 

 
 
 
  	<div class="jumbotron text-center conatiner-fluid">
	 	<table class="table">
        <thead class="thead-dark">
            <tr>
                <th scope="col">Wine</th>
                <th scope="col">Type</th>
                <th scope="col">Winery</th>
                <th scope="col">Vintage</th>
            </tr>
        </thead>
        <tbody>
        	<c:forEach items="${t}" var="item">
        
            <tr>
                <td scope="row"><a href="/wines/${item.id}">${item.name}</a></td>
                <td>${item.type}</td>
                <td>${item.winery}</td>
                 <td>${item.vintage}</td>
            </tr>
                </c:forEach>
            
        </tbody>
    </table>
        <button type="submit" class="btn-btn-success"><a href="/wines/new">Add a Wine!</a></button>
    </div>
  
  
  
  
  
</body>
</html>