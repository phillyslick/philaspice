# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	$(document).on 'change', 'input[type="radio"]', ->
		cost = $(this).data('cost')
		current_cost = $('#grandTotal').data('cost')
		new_cost = (Number) cost + (Number) current_cost
		$('#grandTotal').text("Grand Total: $#{new_cost}")