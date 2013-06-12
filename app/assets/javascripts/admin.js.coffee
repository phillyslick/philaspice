jQuery ->
	$(document).on "submit", '.validate_me', ->
		if $('.required_field').val().length < 3
			alert 'Please Enter a Name For the Product/Variation'
			return false
		else
			return