$ ->
	$(".box").height($(".box").width())
	$(window).resize ->
		$(".box").height($(".box").width())

	a = $(".box").width()
	root = Math.sqrt(Math.pow(a,2) * 2)
	$(".wrapper").height(root)

	$(window).resize ->
		a = $(".box").width()
		root = Math.sqrt(Math.pow(a,2) * 2)
		$(".wrapper").height(root)

	$("#sub").height($("#main").height())
	$(window).resize ->
		$("#sub").height($("#main").height())

	$("#top_bg").height($("#top_bg").width()/940*528+3)

	$("#menu_1").hover ->
			$("#menu_info_1").show()
	,->
			$("#menu_info_1").hide()

	$("#menu_2").hover ->
			$("#menu_info_2").show()
	,->
			$("#menu_info_2").hide()

	$("#menu_3").hover ->
			$("#menu_info_3").show()
	,->
			$("#menu_info_3").hide()

	$("#question_img").load ->
		$("#question_char").height($("#question_img").height())
		(new Taketori()).set({lang:'ja-jp',fontFamily:'serif'}).element('#question_char').toVertical(false)

	(new Taketori()).set({lang:'ja-jp',fontFamily:'serif'}).element('#ans_1').toVertical(false)
	(new Taketori()).set({lang:'ja-jp',fontFamily:'serif'}).element('#ans_2').toVertical(false)
	(new Taketori()).set({lang:'ja-jp',fontFamily:'serif'}).element('#ans_3').toVertical(false)
	(new Taketori()).set({lang:'ja-jp',fontFamily:'serif'}).element('#ans_4').toVertical(false)
	(new Taketori()).set({lang:'ja-jp',fontFamily:'serif'}).element('#ans_5').toVertical(false)

