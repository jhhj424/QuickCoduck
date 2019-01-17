<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ include file="/WEB-INF/view/style/board_detail_css.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>
<body>
<div class="movie-card">
  
  <div class="container">
    
    <a href="#"><img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/195612/hobbit_cover.jpg" alt="cover" class="cover" /></a>
        
    <div class="hero">
            
      <div class="details">
      
        <div class="title1">The Hobbit <span>PG-13</span></div>

        <div class="title2">The Battle of the Five Armies</div>    
        
        <fieldset class="rating">
    <input type="radio" id="star5" name="rating" value="5" /><label class = "full" for="star5" title="Awesome - 5 stars"></label>
    <input type="radio" id="star4half" name="rating" value="4 and a half" /><label class="half" for="star4half" title="Pretty good - 4.5 stars"></label>
    <input type="radio" id="star4" name="rating" value="4" checked /><label class = "full" for="star4" title="Pretty good - 4 stars"></label>
    <input type="radio" id="star3half" name="rating" value="3 and a half" /><label class="half" for="star3half" title="Meh - 3.5 stars"></label>
    <input type="radio" id="star3" name="rating" value="3" /><label class = "full" for="star3" title="Meh - 3 stars"></label>
    <input type="radio" id="star2half" name="rating" value="2 and a half" /><label class="half" for="star2half" title="Kinda bad - 2.5 stars"></label>
    <input type="radio" id="star2" name="rating" value="2" /><label class = "full" for="star2" title="Kinda bad - 2 stars"></label>
    <input type="radio" id="star1half" name="rating" value="1 and a half" /><label class="half" for="star1half" title="Meh - 1.5 stars"></label>
    <input type="radio" id="star1" name="rating" value="1" /><label class = "full" for="star1" title="Sucks big time - 1 star"></label>
    <input type="radio" id="starhalf" name="rating" value="half" /><label class="half" for="starhalf" title="Sucks big time - 0.5 stars"></label>
  </fieldset>
        
        <span class="likes">109 likes</span>
        
      </div> <!-- end details -->
      
    </div> <!-- end hero -->
    
    <div class="description">
      
      <div class="column1">
        <c:forEach var="usetech" items="${loginUser.usetech}" varStatus="g" begin="0">
        <span class="tag">
        ${usetech}
        </span>
        <c:out value="${g.end}" />
        </c:forEach>
      </div> <!-- end column1 -->
      
      <div class="column2">
        
        <p>
        <a href="#">
        read more</a>
        </p>
        
        <div class="avatars">
        
          
        </div> <!-- end avatars -->
        
        
        
      </div> <!-- end column2 -->
    </div> <!-- end description -->
    
   
  </div> <!-- end container -->
</div> <!-- end movie-card -->
</body>
</html>