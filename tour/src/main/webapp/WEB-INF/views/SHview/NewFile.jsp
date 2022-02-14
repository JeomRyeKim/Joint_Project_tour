<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Image Slide</title>
 <style>s

ul{
    list-style:none;
}
.wrapper{
/*     height:700px; */
    /* background-color: lightgray; */
    display: flex;
    justify-content: center;
    align-items: center;
}
.container{
    width:600px;
    height:400px;
    position: relative;
    background-color: antiquewhite;
    overflow: hidden;
}
.slider{
    display: flex;
    position:absolute;
    top:0;
    left:0;
}
.item{
    width:100%;
    height:400px;
    background-color: yellow;
    font-size: 35px;
    text-align: center;
}
.item:nth-child(2){
    background-color: green;
}
.item:nth-child(3){
    background-color: blue;
}

.container ul{
    -webkit-transition: all 0.25s cubic-bezier(1, .01, .32, 1);
    -o-transition: all 0.25s cubic-bezier(1, .01, .32, 1);
    transition: all 0.25s cubic-bezier(1, .01, .32, 1);
}

</style>

<script type="text/javascript">
	var slideWrapper = document.querySelector('.container');
	var slides = document.querySelectorAll('.item');
	var totalSlides = slides.length; // item의 갯수
	
	
	var sliderWidth = slideWrapper.clientWidth; // container의 width
	var slideIndex = 0;
	var slider = document.querySelector('.slider');
	
	slider.style.width = sliderWidth * totalSlides + 'px';
	
	showSlides()
	
	function showSlides() {
	    for(var i=0;i<slides.length;i++){
	        slider.style.left = -(sliderWidth * slideIndex) + 'px';    
	    }
	    slideIndex++;
	    if (slideIndex === totalSlides) {
	        slideIndex = 0;
	    }
	    setTimeout(showSlides, 2000); 
	}
</script>
</head>
<body>
    <div class="wrapper">
        <div class="container">
            <ul class="slider">
                <li class="item">1st</li>
                <li class="item">2nd</li>
                <li class="item">3rd</li>
            </ul>
        </div>
    </div>
</body>
</html>