jQuery ->
	new SliderCropper();
	
class SliderCropper
	constructor: ->
		$('#cropbox').Jcrop
			aspectRatio: 1
			setSelect: [0, 0, 600, 600]
			onSelect: @update
			onChange: @update

	update: (coords) =>
		$('#slider_crop_x').val(coords.x)
		$('#slider_crop_y').val(coords.y)
		$('#slider_crop_w').val(coords.w)
		$('#slider_crop_h').val(coords.h)