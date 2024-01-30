function accordionLoad() {
 
    $(".accordion-header").removeClass("expanded");
    $(".accordion-content").hide();
 
    $(".accordion-header").bind("click", function(){
        $(this).toggleClass("expanded");
        $(this).siblings(".accordion-content").slideToggle();
    })

    $('.accordion-description').hide();
    $('.accordion-item').on('mouseenter', function ()
    {
        // $(this).next().siblings
        $('.accordion-description').fadeOut();
        $(this).find('.accordion-description').fadeIn();

    });
 
    $(".expand-all").bind("click",function(){
        $(this).siblings(".accordion").find(".accordion-content").slideDown();
        $(this).siblings(".accordion").find(".accordion-header").addClass("expanded");
    })
 
    $(".collapse-all").bind("click",function(){
        $(this).siblings(".accordion").find(".accordion-content").slideUp();
        $(this).siblings(".accordion").find(".accordion-header").removeClass("expanded");
    })
}
 
function lastnode(){
	//alert($('#updateaccordion').length);
	//alert($("ul li:last").text());
	/*$('ul li:last').find(".accordion-content").slideDown();
	$('ul li:last').find(".accordion-header").addClass("expanded");
	alert("lastnode");
	*/
	$('updateaccordion li:last').each(function(){
		$(this).slideDown();
	    $(this).addClass("expanded");
	});
}
$(document).ready(function(){
    accordionLoad();
});