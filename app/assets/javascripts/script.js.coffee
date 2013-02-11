$ ->
  #SideBar for AllPages
	$("#sub").height($("#main").height())
	$(window).resize ->
		$("#sub").height($("#main").height())

  #Set CardHeight for Review/Exam Pages
	$("#question_img").load ->
		$("#question_char").height($("#question_img").height())
		(new Taketori()).set({lang:'ja-jp',fontFamily:'serif'}).element('#question_char').toVertical(false)

  #Apply Taketori for Review/Exam Pages
	(new Taketori()).set({lang:'ja-jp'}).element('#ans_1').toVertical(false)
	(new Taketori()).set({lang:'ja-jp'}).element('#ans_2').toVertical(false)
	(new Taketori()).set({lang:'ja-jp'}).element('#ans_3').toVertical(false)
	(new Taketori()).set({lang:'ja-jp'}).element('#ans_4').toVertical(false)
	(new Taketori()).set({lang:'ja-jp'}).element('#ans_5').toVertical(false)

