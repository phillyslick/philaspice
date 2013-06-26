jQuery ->
	$('select#state').on "change", ->
		state = $(this).val()
		address = $(this).data('href')
		order_id = $(this).data('id')
		$('h4#orderStateUpdate').load("#{address}?order_id=#{order_id}&state=#{state} h4#orderStateUpdate")