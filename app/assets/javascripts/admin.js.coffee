jQuery ->
	$(document).on "submit", '.validate_me', ->
		if $('.required_field').val().length < 3
			alert 'Please Enter a Name For the Product/Variation'
			return false
		else if $('.required_price').val().length < 1
			alert 'Please Enter a Price For the Product/Variation'
			return false
		else if $('.required_weight').val().length < 1
			alert 'Please Enter a Weight For the Product/Variation'
			return false
		else
			return