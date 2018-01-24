( function( $ ){

	var price = $('input[name="price"]').val();
	var seats = $('#number_seats').val();
	var total = price * seats;

	$('#total_amount').val(total);

	$('#number_seats').bind('input', function() {
		seats = $(this).val();
		total = price * seats;

		$('#total_amount').val(total);
	});


} )( jQuery );