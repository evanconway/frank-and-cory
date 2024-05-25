event_inherited();

original_x = x;
original_y = y;
positions = [noone];

on_click = function() {
	global.clickable_dragged = id;
};

on_release = function() {
	
	show_debug_message($"draggable {id} released");
};

draw = function() {
	// account for snapping to position objects
	if (!visible) return;
	
	if (global.clickable_dragged == id) {
		draw_sprite(sprite_index, image_index, mouse_x, mouse_y);
	} else {
		draw_self();
	}
	
	image_index = 0;
	visible = true;
};
