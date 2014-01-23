# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

global = global ? this

set_lecons_arrows = ->
	$("#images > img:first-child").show()
	$("#right_arrow").click(->
		$("#images > img:not(:hidden)").fadeOut(->
			$(this).fadeOut()
			if $(this).next().length == 0
				$("#images > img:first-child").fadeIn()
			else
				$(this).next().fadeIn()
		)
	)
	$("#left_arrow").click(->
		$("#images > img:not(:hidden)").fadeOut(->
			$(this).fadeOut()
			if $(this).prev().length == 0
				$("#images > img:last-child").fadeIn()
			else
				$(this).prev().fadeIn()
		)
	)

change_comment = ->
	current_object = $(".footer_comment:visible")
	current_object.fadeOut ->
		if current_object.next.length == 0
			$(".footer_comment:first-child").fadeIn()
		else
			current_object.next().fadeIn()

set_footer_comments = ->
	$(".footer_comment:first-child").show()
	window.setInterval change_comment , 10000

init_pages = ->
	set_lecons_arrows()
	set_footer_comments()

$ init_pages
document.addEventListener "page:load", init_pages

global.init_pages = init_pages