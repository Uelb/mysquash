# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

handleSuccess = (data, textStatus, jqXHR) ->
	$.get 'inscriptions', {tournament_id: $("#tournament_id").val()}, (data) ->
		$("#participants_list").html(data)

handleFailure = () ->
	console.log "fail"

set_tournament_form = () ->
	$("#tournament_form").submit (evt) ->
		evt.preventDefault()
		$.get("/inscriptions/check_user", {email: $("#tournament_form #email").val()})
		.success(handleSuccess
		)
		.fail(handleFailure)

window.handleSuccess = handleSuccess
window.set_tournament_form = set_tournament_form

$(window).bind "load", () ->
	set_tournament_form()