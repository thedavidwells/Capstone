'use strict';
$('.nav a').click(function(){
	console.log('clicked', $(this).html());
	$(this).parent().siblings().removeClass('active');
	$(this).parent().addClass('active');
});