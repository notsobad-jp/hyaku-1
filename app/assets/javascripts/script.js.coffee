$ ->
  #Set CardHeight for Review/Exam Pages
	$("#question_img").on("load resize", ->
		$("#question_char").height($("#question_img").height())
	)

  #Apply Taketori for Review/Exam Pages
	(new Taketori()).set({lang:'ja-jp'}).element('#question_char').toVertical(false)
	(new Taketori()).set({lang:'ja-jp'}).element('#ans_1').toVertical(false)
	(new Taketori()).set({lang:'ja-jp'}).element('#ans_2').toVertical(false)
	(new Taketori()).set({lang:'ja-jp'}).element('#ans_3').toVertical(false)
	(new Taketori()).set({lang:'ja-jp'}).element('#ans_4').toVertical(false)
	(new Taketori()).set({lang:'ja-jp'}).element('#ans_5').toVertical(false)

	$('tbody tr[data-href]').addClass('clickable').delegate('*', 'click', ->
		if ( this.tagName != 'A' )
		  window.location = $(this).parents('tr').data('href')
	  return false
  )


	$(window).on("load resize", ->
		$(".index_box").height($(".index_box").width())
	)
	$(window).on("load resize", ->
	  $("#index_container").height($(".index_box").width() * 3)
	)

  #SideBar for AllPages
	$(window).on("load resize", ->
		$("#sub").height($("#main").height())
	)

