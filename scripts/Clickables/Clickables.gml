global.clickable_hovered = noone;
global.clickable_dragged = noone;

global.draggable_position_map = ds_map_create();
global.position_draggable_map = ds_map_create();

function draggable_set_position(draggable=noone, position=noone) {
	// undo current mapping
	var current_position = ds_map_find_value(global.draggable_position_map, draggable);
	if (current_position != noone) ds_map_set(global.position_draggable_map, current_position, noone);
	ds_map_set(global.draggable_position_map, draggable, position);
	ds_map_set(global.position_draggable_map, position, draggable);
}

function __clickables_get_all() {
	var clickable_ids = [];
	with (obj_clickable) {
		array_push(clickable_ids, id);
	}
	array_sort(clickable_ids, function(id_a, id_b) {
		return id_a.depth - id_b.depth;
	});
	return clickable_ids;
}

function update_clickable(clickable_id) {
	with (clickable_id) {
		if (global.clickable_hovered == noone) {
			if (position_meeting(mouse_x, mouse_y, id)) global.clickable_hovered = id;
			clickable_id.pre_update();
			if (clickable_id.disabled) return;
			if (mouse_check_button_pressed(mb_left) && global.clickable_hovered == id) {
				on_click();
			}
		}
	}
}

function clickables_update() {	
	if (global.clickable_dragged == noone) {
		var clickable_ids = __clickables_get_all();
		array_foreach(clickable_ids, update_clickable);
	}
	
	with (obj_draggable) {
		draggable_update();
	}
}

global.clickable_blackout_alpha = 0;

function __clickable_draw(clickable = noone) {
	with (clickable) {
		pre_draw();
		draw();
		if (global.clickable_hovered == id && !clickable.disabled) {
			shader_set(sh_hovered);
			draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, 1);
			shader_reset();
		}
	}
}

function clickables_draw() {
	draw_set_alpha(1);
	var clickable_ids = __clickables_get_all();
	array_foreach(array_reverse(clickable_ids), function(clickable_id) {
		if (global.clickable_dragged == clickable_id) return;
		__clickable_draw(clickable_id);
	});
	if (global.clickable_dragged != noone) {
		__clickable_draw(global.clickable_dragged);
	}
}
