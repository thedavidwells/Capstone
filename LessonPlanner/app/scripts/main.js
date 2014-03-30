'use strict';

function scrollTo(ele, time){
	time = time || 2000;
	$('html, body').animate({
        scrollTop: $(ele).offset().top - 30
    }, time);
}
var slides;
var slidePos = 0;
function swapSlides(slide1, slide2, also){
	slide1.fadeOut(500, function(){
		slide2.fadeIn(500);
		if(also){
			also();
		}
	});
}
function nextSection(){
	var cSlide = $(slides[slidePos++]);
	var nSlide = $(slides[slidePos]);
	var displayBackButton = nSlide.attr('displayBackButton');
	var displayContinueButton = nSlide.attr('displayContinueButton');
	$('#backButton').fadeOut(500);
	$('#continueButton').fadeOut(500);
	swapSlides(cSlide, nSlide, function(){
		if(displayBackButton === 'true'){
			$('#backButton').fadeIn(500);
		}
		if(displayContinueButton === 'true'){
			$('#continueButton').fadeIn(500);
		}
	});
}
function lastSection(){
	var cSlide = $(slides[slidePos--]);
	var nSlide = $(slides[slidePos]);
	var displayBackButton = nSlide.attr('displayBackButton');
	var displayContinueButton = nSlide.attr('displayContinueButton');
	$('#backButton').fadeOut(500);
	$('#continueButton').fadeOut(500);
	swapSlides(cSlide, nSlide, function(){
		if(displayBackButton === 'true'){
			$('#backButton').fadeIn(500);
		}
		if(displayContinueButton === 'true'){
			$('#continueButton').fadeIn(500);
		}
	});
}

$(document).ready(function(){


	$('.fullscreen').css('height', $( window ).height());
	$('.fullscreen').css('padding-top', $( '#header' ).height());



	// setup Navigation clicks
	$('.nav a').click(function(){
		console.log('clicked', $(this).html());
		$(this).parent().siblings().removeClass('active');
		$(this).parent().addClass('active');
		var target = $(this).attr('target');
		console.log(target);
		scrollTo(target);
		return false;
	});

	$('.continue').click(nextSection);
	$('#backButton').click(lastSection);
	// Name course screen
	$('#courseTitle').keyup(function(){
		var v = $(this).val();
		if(v.length > 5){
			$('#continueButton').fadeIn(500);
		} else {
			$('#continueButton').fadeOut(500);
		}	
	});
	slides = $('#startPlanning').children('.slide');


});

