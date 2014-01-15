# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

handleSuccess = (data, textStatus, jqXHR) ->
	console.log(jqXHR)
	$("#registration_form").hide()
	if jqXHR.status == 201
		#Then the user is created but has not confirmed is email. A new confirmation email has been sent. 
		#We should notify the user of this new email and hide the registration form if already opened
		$("#content .error-title").remove()
		$('#result_wrapper').html(data)
	else if jqXHR.status == 200
		#The user is recognized. We nees to make sure that the person asking for the inscription is the correct person.
		$.get '/inscriptions/new', {tournament_id: $("#tournament_id").val(), email: $("#email").val()}, (data) ->
			$(".notice.alert").remove()
			$("#email").val("")
			$('#result_wrapper').html(data)

handleFailure = (data) ->
	console.log(data)
	$("#registration_form #user_email").val $("#tournament_form #email").val()
	$("#registration_form").show()

set_tournament_form = () ->
	$("#tournament_form").submit (evt) ->
		evt.preventDefault()
		email = $("#tournament_form #email").val()
		if email
			$.get("/inscriptions/check_user", {email: $("#tournament_form #email").val()})
			.success(handleSuccess
			)
			.fail(handleFailure)
		else
			alert("Vous devez entrer une adresse email.")
			return false

window.handleSuccess = handleSuccess
window.handleFailure = handleFailure
window.set_tournament_form = set_tournament_form

$(window).bind "load", () ->
	set_tournament_form()
