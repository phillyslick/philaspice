# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	$('#mainSlider').bjqs
		width: 900
		height: 900
		animtype: 'fade'
		responsive: 'true'
		
	$('#line_item_variant_id').on "change", ->
		variant_id = $(this).val()
		address = "?variant_id=#{variant_id}"
		$('#priceSelect').load("#{address} #priceSelect")