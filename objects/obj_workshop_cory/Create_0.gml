event_inherited();

depth = -1;

disabled = true;

original_draw = draw;

draw = function() {
	var original_image_index = image_index;
	original_draw();
	image_index = original_image_index;
};
