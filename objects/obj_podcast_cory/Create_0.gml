event_inherited();

disabled = true;

original_draw = draw;

draw = function() {
	cory_set_expression()
	// I don't remember why we have this?
	var original_image_index = image_index;
	original_draw();
	image_index = original_image_index;
};
