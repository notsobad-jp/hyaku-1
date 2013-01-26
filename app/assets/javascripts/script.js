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

	$("#sub").height($("#main").height());
	$(window).resize(function(){
		$("#sub").height($("#main").height());
	});

  $("#menu_1").hover(
		function(){
			$("#menu_info_1").show();
		},function(){
			$("#menu_info_1").hide();
	});

  $("#menu_2").hover(
		function(){
			$("#menu_info_2").show();
		},function(){
			$("#menu_info_2").hide();
	});

  $("#menu_3").hover(
		function(){
			$("#menu_info_3").show();
		},function(){
			$("#menu_info_3").hide();
	});
});

