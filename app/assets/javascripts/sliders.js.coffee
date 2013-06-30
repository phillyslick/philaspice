jQuery ->
	new SliderCropper();
	new VariantCropper();
	new OptionCropper();
	
class SliderCropper
	constructor: ->
		$('#cropbox').Jcrop
			aspectRatio: 900/600
			onSelect: @update
			onChange: @update

	update: (coords) =>
		$('#slider_crop_x').val(coords.x)
		$('#slider_crop_y').val(coords.y)
		$('#slider_crop_w').val(coords.w)
		$('#slider_crop_h').val(coords.h)

class VariantCropper
	constructor: ->
		$('#cropbox_variant').Jcrop
			aspectRatio: 1
			onSelect: @update
			onChange: @update

	update: (coords) =>
		$('#variant_crop_x').val(coords.x)
		$('#variant_crop_y').val(coords.y)
		$('#variant_crop_w').val(coords.w)
		$('#variant_crop_h').val(coords.h)
		
class VariantCropper
	constructor: ->
		$('#cropbox_option').Jcrop
			aspectRatio: 1
			onSelect: @update
			onChange: @update

	update: (coords) =>
		$('#option_crop_x').val(coords.x)
		$('#option_crop_y').val(coords.y)
		$('#option_crop_w').val(coords.w)
		$('#option_crop_h').val(coords.h)