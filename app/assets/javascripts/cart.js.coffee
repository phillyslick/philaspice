# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).keyup (e) ->
	if e.keyCode == 27 && $('#cart').data("open") == true
		toggleCart()
		
$(document).on "click", "#cartTrigger", ->
	toggleCart()
	
$(document).on "click", '#closeCart', ->
	toggleCart()

toggleCart =  ->
	if $('#cart').data("open") == false
		$('#cart').data("open", true) 
		$('body').append("<div id='overlay'></div>")
		$('#overlay').show()
		$('#cart').animate
			right: "0%"
	else
		$('#cart').data("open", false)
		$('#cart').animate
			right: "-100%"
		$('#overlay').remove()