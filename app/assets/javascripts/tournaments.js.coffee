# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
global = global ? this
dont_hide_notice = false
handleSuccess = (data, textStatus, jqXHR) ->
	$("#registration_form").hide()
	if jqXHR.status == 201
		#Then the user is created but has not confirmed is email. A new confirmation email has been sent. 
		#We should notify the user of this new email and hide the registration form if already opened
		$("#content .error-title").remove()
		$('#result_wrapper').html(data)
	else if jqXHR.status == 200
		#The user is recognized. We nees to make sure that the person asking for the inscription is the correct person.
		$.get '/inscriptions/new', {tournament_id: $("#tournament_id").val(), email: $("#email").val()}, (data) ->
			if !dont_hide_notice
				$(".notice.alert").hide()
			dont_hide_notice = false
			$('#result_wrapper').html(data)
			$("#email_confirmation").val($("#email").val())
	else if  jqXHR.status == 202
		$("#result_wrapper").html("<div class='notice alert'>Un message contenant un lien de confirmation a été envoyé à votre addresse email. Ouvrez ce lien pour activer votre compte.</div>")
		$("#result_wrapper").show()
handleFailure = (data) ->
	console.log(data)


set_tournament_form = () ->
	if $("#confirmed_email").val()
		$("#registration_form").show()
		$("#user_email").val($("#confirmed_email").val())
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

global.handleSuccess = handleSuccess
global.handleFailure = handleFailure
global.set_tournament_form = set_tournament_form

init = ->
	set_tournament_form()
	set_popin_close_button()
	text = "Les informations que vous avez entrées sont incorrects."
	if $(".notice.alert").html() == text
		$("#tournament_form").submit()
		dont_hide_notice = true


$ init
document.addEventListener "page:load", init