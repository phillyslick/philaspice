# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	editableCart()

reloadCart = ->
	if $('#theCart').length > 0
		$('#theCart').load('/storefront/index #theCart', ->
			editableCart())
	else
		$('#orderItems').load('/orders/new #orderItems', ->
			editableCart())
		

editableCart = ->
	if $('.quantity').length > 0
		$('.quantity').editable(
			ajaxOptions:
				type: "put"
			mode: "inline",
			onblur: "submit",
			success: ->
				reloadCart())
	