event_inherited();

ds_map_set(global.draggable_position_map, id, noone);

position_snapped = noone;

draggable_update = function() {
	position_snapped = noone;
	if (global.clickable_dragged != id) return;
	if (global.clickable_hovered == id) global.clickable_hovered = noone; // stop hover highlight from showing for 1 frame
	with (obj_draggable_position) {
		/*
		We don't have to specifically forbid snapping to the position the draggable
		is already at because draggables cannot snap to an occupied position. While
		being dragged a draggable is still considered to occupy its old position.
		*/
		
		var draggable_here = ds_map_find_value(global.position_draggable_map, id);
		if (draggable_here == noone && point_distance(x, y, mouse_x, mouse_y) < 70) {
			other.position_snapped = id;
		}
	}
	if (mouse_check_button_released(mb_left)) {
		global.clickable_dragged = noone;
		
		var position_old = ds_map_find_value(global.draggable_position_map, id);
		var position_new = position_snapped == noone ? position_old : position_snapped; 
		
		if (position_snapped != noone) {
			draggable_set_position(id, position_snapped);
			x = position_snapped.x;
			y = position_snapped.y;
			position_snapped = noone;
		}
		
		show_debug_message($"draggable \"{id}\" move from \"{position_old}\" to \"{position_new}\"");
	}
};

on_click = function() {
	global.clickable_dragged = id;
};

draw = function() {
	// account for snapping to position objects
	if (!visible) return;
	
	if (global.clickable_dragged == id) {		
		if (position_snapped != noone) draw_sprite(sprite_index, image_index, position_snapped.x, position_snapped.y);
		else draw_sprite(sprite_index, image_index, mouse_x, mouse_y);
	} else {
		draw_self();
	}
	
	image_index = 0;
	visible = true;
};
