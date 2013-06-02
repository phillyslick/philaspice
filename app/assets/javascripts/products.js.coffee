jQuery ->
	$('#weightModal').modal('hide')
	$('FORM').nestedFields()

	$('.triggerWeight').on "click", ->
		the_link = $(this).attr('href')
		$('#myModal').load("#{the_link} .row-fluid", ->
				$('#myModal').modal('show'))
		return false