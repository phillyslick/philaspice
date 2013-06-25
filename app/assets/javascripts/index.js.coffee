# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	$('#mainSlider').bjqs
		width: 900
		height: 900
		animtype: 'fade'
		responsive: 'true'
		nexttext: "<span class='prevAarow'></span>"
		prevtext: "<span class='nextAarow'></span>"
		showmarkers: false
		
	$('#line_item_variant_id').on "change", ->
		variant_id = $(this).val()
		address = "?variant_id=#{variant_id}"
		$('#priceSelect').load("#{address} #priceSelect")
		
	$(document).on "change", "#product_category_id", ->
		category_id = $(this).val()
		the_link = $(this).next("input#path").val()
		$('#subload').load("#{the_link}?category=#{category_id} #subload")
	
	if $('#subcategories').length > 0
		setUpSliders()
		$('h4.opener').on "click", ->
			unless $(this).hasClass('active')
				$('h4.active').removeClass('active')
				$(this).addClass('active')
				$('ul.active').slideUp().removeClass('active')
				$(this).next('ul.subcategory').slideDown().addClass('active')

setUpSliders = ->
	$('.subcategory').hide()
	$('.active').slideDown()