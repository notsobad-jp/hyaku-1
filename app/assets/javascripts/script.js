$(function(){
	$(".box").height($(".box").width());

	$(window).resize(function(){
		$(".box").height($(".box").width());
	});

	a = $(".box").width();
	root = Math.sqrt(Math.pow(a,2) * 2);
	$(".wrapper").height(root);

	$(window).resize(function(){
		a = $(".box").width();
		root = Math.sqrt(Math.pow(a,2) * 2);
		$(".wrapper").height(root);
	});

	$("#sub").height($("#container").height());

	$(window).resize(function(){
		$("#sub").height($("#container").height());
	});
});

