event_inherited();

depth = -1;

disabled = true;

original_draw = draw;

draw = function() {
	// I don't remember why we have this?
	var original_image_index = image_index;
	original_draw();
	image_index = original_image_index;
};
