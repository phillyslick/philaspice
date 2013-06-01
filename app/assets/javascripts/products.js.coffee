jQuery ->

	$('FORM').nestedFields()
	
	$(document).on "change", '#product_category_id', ->
		$(this).closest('form').submit()

