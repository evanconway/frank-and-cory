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
	original_update();
	
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
