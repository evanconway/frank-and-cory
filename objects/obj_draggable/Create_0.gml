event_inherited();

ds_map_set(global.draggable_position_map, id, noone);

position_snapped = noone;

draggable_update = function() {
	position_snapped = noone;
	if (global.clickable_dragged != id) return;
	with (obj_draggable_position) {
		var draggable_here = ds_map_find_value(global.position_draggable_map, id);
		if (draggable_here == noone && distance_to_point(mouse_x, mouse_y) < 150) {
			other.position_snapped = id;
		}
	}
	if (mouse_check_button_released(mb_left)) {
		global.clickable_dragged = noone;
		if (position_snapped != noone) {
			// undo current mapping
			var current_position = ds_map_find_value(global.draggable_position_map, id);
			ds_map_set(global.position_draggable_map, current_position, noone);
			
			ds_map_set(global.draggable_position_map, id, position_snapped);
			ds_map_set(global.position_draggable_map, position_snapped, id);
			x = position_snapped.x;
			y = position_snapped.y;
			position_snapped = noone;
		}
	}
};

on_click = function() {
	global.clickable_dragged = id;
};

on_release = function() {
	show_debug_message($"draggable {id} released");
};

draw = function() {
	// account for snapping to position objects
	if (!visible) return;
	
	var position = ds_map_find_value(global.draggable_position_map, id);
	
	if (global.clickable_dragged == id) {
		if (position_snapped != noone) draw_sprite(sprite_index, image_index, position_snapped.x, position_snapped.y);
		else draw_sprite(sprite_index, image_index, mouse_x, mouse_y);
	} else {
		draw_self();
	}
	
	image_index = 0;
	visible = true;
};