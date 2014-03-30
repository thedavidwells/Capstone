'use strict';

function scrollTo(ele, time){
	time = time || 1000;
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

function setupScreenSize(){
	$('.fullscreen').css('height', $( window ).height());
	$('.fullscreen').css('padding-top', $( '#header' ).height());
}
function checkvisible( elem ) {
	var docViewTop = $(window).scrollTop();
    var docViewBottom = docViewTop + $(window).height();

    var elemTop = $(elem).offset().top;
    var elemBottom = elemTop + $(elem).height();

    return ((elemBottom <= docViewBottom) && (elemTop >= docViewTop));
}
$(document).ready(function(){

	setupScreenSize();
	$(window).resize(setupScreenSize);
	



	// setup Navigation clicks
	$('.nav a').click(function(){
		var target = $(this).attr('target');
		scrollTo(target);
		return false;
	});
	var targets = $('.nav a');
	$(window).scroll(function(){
		for(var i = 0; i < targets.length; i++){
			var ele = $(targets[i]);
			var target = ele.attr('target');
			console.log('Checking if ' + target + ' is on screen', checkvisible(target));
			if(checkvisible(target)){
				ele.parent().siblings().removeClass('active');
				ele.parent().addClass('active');
			}
		}
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

