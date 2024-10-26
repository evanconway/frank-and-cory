event_inherited();

original_update = draggable_update;

set_depth_for_position = function(position=noone) {
	if (position == noone) {
		depth = 0;
		return;
	}
	depth = position.depth;
}

draggable_update = function() {
	// original update sets new position pairings
	if (!disabled) {
		original_update();
	}
	
	/*
	The tape slots work by rendering a sprite of the slot over the reel asset.
	This gives the illusion of it being placed into a slot. But in order for
	the layered look to work, all reels and slots must be at the correct render
	depth. A reel's depth is determined by its slot. Here is where we will set
	that depth.
	*/
	var current_position = ds_map_find_value(global.draggable_position_map, id);
	set_depth_for_position(current_position);
};

original_draw = draw;

draw = function() {
	original_draw();
	
	/*
	A bit hacky, but setting the disabled status of reels here keeps the logic
	contained to this object. So we're treating this like a "draw" and "end_step"
	event.
	*/
	if (!disabled) {
		var current_position = ds_map_find_value(global.draggable_position_map, id);
		if (array_contains(global.podcast_tape_slots[0], current_position)) {
			if (podcast_get_is_column_correct(0)) {
				disabled = true;
			}
		}
		if (array_contains(global.podcast_tape_slots[1], current_position)) {
			if (podcast_get_is_column_correct(1)) {
				disabled = true;
			}
		}
		if (array_contains(global.podcast_tape_slots[2], current_position)) {
			if (podcast_get_is_column_correct(2)) {
				disabled = true;
			}
		}
		if (array_contains(global.podcast_tape_slots[3], current_position)) {
			if (podcast_get_is_column_correct(3)) {
				disabled = true;
			}
		}
	}
	
	if (podcast_get_is_complete()) disabled = false;
	
	if (disabled) {
		shader_set(sh_disable_light);
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, 1);
		shader_reset();
	}
};