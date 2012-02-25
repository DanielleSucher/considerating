$(document).ready(function() {  
	if(jQuery.browser.mobile) {
		$(".rating_logged_out").html("<br /><select name='rating'><option value='10'>considerate</option><option value='20'>2</option><option value='30'>3</option><option value='40'>4</option><option value='50'>5</option><option value='60'>6</option><option value='70'>7</option><option value='80'>8</option><option value='90'>9</option><option value='100'>creepy</option></select>"); 
		$(".rating_logged_in").html("<br /><select name='rating'><option value='1.0'>considerate</option><option value='2.0'>2</option><option value='3.0'>3</option><option value='4.0'>4</option><option value='5.0'>5</option><option value='6.0'>6</option><option value='7.0'>7</option><option value='8.0'>8</option><option value='9.0'>9</option><option value='10.0'>creepy</option></select>"); 
	}
	$(":range").rangeinput();
});