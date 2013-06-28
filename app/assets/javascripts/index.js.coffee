# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	$('#addyCopy').on 'click', ->
		copyBillingAddress()
		false
		
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
		$('#variantImage').load("#{address} #variantImage")
		
	$(document).on "change", "#product_category_id", ->
		category_id = $(this).val()
		the_link = $(this).next("input#path").val()
		$('#subload').load("#{the_link}?category=#{category_id} #subload")
	
	if $('#subcategories').length > 0
		setUpSliders()
		$('h4.opener').on "click", ->
			unless $(this).hasClass('active')
				openAndCloseSections($(this))
			
setUpSliders = ->
	$('.subcategory').hide()
	$('.active').slideDown()

openAndCloseSections = (h4) ->
	$('h4.active').removeClass('active')
	h4.addClass('active')
	$('ul.active').slideUp().removeClass('active')
	h4.next('ul.subcategory').slideDown().addClass('active')

copyBillingAddress = ->
	fields = {
		street: $('#order_addresses_attributes_0_address1').val()
		address2: $('#order_addresses_attributes_0_address2').val()
		city: $('#order_addresses_attributes_0_city').val()
		state: $('#order_addresses_attributes_0_state').val()
		zip: $('#order_addresses_attributes_0_zip').val()
	}
	$('#order_addresses_attributes_1_address1').val(fields.street)
	$('#order_addresses_attributes_1_address2').val(fields.address2)
	$('#order_addresses_attributes_1_city').val(fields.city)
	$('#order_addresses_attributes_1_state').val(fields.state)
	$('#order_addresses_attributes_1_zip').val(fields.zip)
	false