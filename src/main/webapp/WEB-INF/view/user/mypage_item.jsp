<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%@ include file="/WEB-INF/view/style/user_mypage_item.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<div class="w3-container w3-card w3-white w3-round w3-margin">
		<h2 class="w3-text-grey w3-padding-16">
			<i class="fa fa-cart-plus fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>상품정보
		</h2>
		 <div class="w3-container">
          <h2 class="w3-text-grey">
			<i class="fa fa-certificate fa-fw  w3-xxlarge w3-text-teal"></i> 공고 Top 10
		 </h2>
          	<div class="container" style="max-width: 100%">
			<div class="content-block">
				<div class="content-block__effect">
					<div class="portfolio-effect">
						<!-- portfolio item -->
						<div
							class="portfolio-item portfolio-effect__item portfolio-item--eff4">
							<img class="portfolio-item__image"
								src="../workpic/10.jpg" alt="Portfolio Item"
								width="826" height="551">
							<div class="portfolio-item__info">
								<h3 class="portfolio-item__header">공고 글 10개 가능</h3>
								<div class="portfolio-item__links">
									<div class="portfolio-item__link-block">
										<a class="portfolio-item__link" href="#" title="Link Title">
											<i class="fa fa-reply"style="font-size:25px;"></i>
										</a>
									</div>
									<div class="portfolio-item__link-block">
										<a class="portfolio-item__link" href="../user/mypage_itempay.duck?id=${loginUser.userid }&itemtype=1" title="Link Title">
											<i class="fa fa-cart-plus"style="font-size:25px;"></i>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
          <hr>
       </div>
        <div class="w3-container">
          <h2 class="w3-text-grey">
			<i class="fa fa-certificate fa-fw  w3-xxlarge w3-text-teal"></i> 공고 Top 20
		 </h2>
          	<div class="container" style="max-width: 100%">
			<div class="content-block">
				<div class="content-block__effect">
					<div class="portfolio-effect">
						<!-- portfolio item -->
						<div
							class="portfolio-item portfolio-effect__item portfolio-item--eff4">
							<img class="portfolio-item__image"
								src="../workpic/20.png" alt="Portfolio Item"
								width="826" height="551">
							<div class="portfolio-item__info">
								<h3 class="portfolio-item__header">공고 글 20개 가능</h3>
								<div class="portfolio-item__links">
									<div class="portfolio-item__link-block">
										<a class="portfolio-item__link" href="#" title="Link Title">
											<i class="fa fa-reply"style="font-size:25px;"></i>
										</a>
									</div>
									<div class="portfolio-item__link-block">
										<a class="portfolio-item__link" href="../user/mypage_itempay.duck?id=${loginUser.userid }&itemtype=2" title="Link Title">
											<i class="fa fa-cart-plus"style="font-size:25px;"></i>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
          <hr>
       </div>
        <div class="w3-container">
          <h2 class="w3-text-grey">
			<i class="fa fa-certificate fa-fw  w3-xxlarge w3-text-teal"></i> 공고 Top 30
		 </h2>
          	<div class="container" style="max-width: 100%">
			<div class="content-block">
				<div class="content-block__effect">
					<div class="portfolio-effect">
						<!-- portfolio item -->
						<div
							class="portfolio-item portfolio-effect__item portfolio-item--eff4">
							<img class="portfolio-item__image"
								src="../workpic/30.png" alt="Portfolio Item"
								width="826" height="551">
							<div class="portfolio-item__info">
								<h3 class="portfolio-item__header">공고 글 30개 가능</h3>
								<div class="portfolio-item__links">
									<div class="portfolio-item__link-block">
										<a class="portfolio-item__link" href="#" title="Link Title">
											<i class="fa fa-reply"style="font-size:25px;"></i>
										</a>
									</div>
									<div class="portfolio-item__link-block">
										<a class="portfolio-item__link" href="../user/mypage_itempay.duck?id=${loginUser.userid }&itemtype=3" title="Link Title">
											<i class="fa fa-cart-plus"style="font-size:25px;"></i>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
          <hr>
       </div>
	</div>
</body>
</html>