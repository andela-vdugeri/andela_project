$(document).ready(function(){
	setTimeOut(popup, 3000);
	function popup(){
		$('#details').css('display', 'block');
	}
	$('checkout').click(function(){
		$('#details').css('display', 'block')
	})
})