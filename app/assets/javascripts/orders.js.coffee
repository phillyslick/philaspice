jQuery ($) ->	
  $('#exp-year').hide()
  $('#exp-month').hide()	
  $('#card_month').change ->
	  month = $(this).val()
	  $('#exp-month').val(month)

  $('#card_year').change ->
	  year = $(this).val()
	  $('#exp-year').val(year)


  $("#new_transaction").submit (event) ->
    $form = $(this)
    
    # Disable the submit button to prevent repeated clicks
    $form.find("button").prop "disabled", true
    Stripe.createToken $form, stripeResponseHandler
    
    # Prevent the form from submitting with the default action
    false

stripeResponseHandler = (status, response) ->
  $form = $("#new_transaction")
  if response.error
    
    # Show the errors on the form
    $form.find(".payment-errors").text response.error.message
    $form.find("button").prop "disabled", false
  else
    
    # token contains id, last4, and card type
    token = response.id
    
    # Insert the token into the form so it gets submitted to the server
    $form.append $("<input type=\"hidden\" name=\"stripeToken\" />").val(token)
    
    # and submit
    $form.get(0).submit()