# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
global = global ? this
set_popin_close_button = ->
	$(".close").click ->
		$("body").removeClass "popin"
		$(".wrap-popin").hide()

global.set_popin_close_button = set_popin_close_button