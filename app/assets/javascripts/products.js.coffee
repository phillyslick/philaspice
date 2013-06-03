jQuery ->
	$('#weightModal').modal('hide')
	$('FORM').nestedFields()

	$('.triggerWeight').on "click", ->
		the_link = $(this).attr('href')
		$('#myModal').load("#{the_link} .row-fluid", ->
				$('#myModal').modal('show'))
		return false
		
	$('.triggerBlank').on "click", ->
		the_link = $(this).attr('href')
		$('#myModal').load("#{the_link} #content", ->
				$('#myModal').modal('show'))
		return false
	
	$('.tip').tooltip()
	
	$(document).on "change", "#product_category_id", ->
		category_id = $(this).val()
		the_link = $(this).next("input#path").val()
		$('#subload').load("#{the_link}?category=#{category_id} #subload")