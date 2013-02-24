# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  #BackgroundImage for Home#Top
	$("#top_bg").height($("#top_bg").width()/940*528+3)

	#BoxSizing for Home#Index
	$(window).on("load resize", ->
	  $(".box").height($(".box").width())
	)

	$(window).on("load resize", ->
		a = $(".box").width()
		root = Math.sqrt(Math.pow(a,2) * 2)
		$(".wrapper").height(root)
	)

  #MenuInfoBox for Home#Index
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
