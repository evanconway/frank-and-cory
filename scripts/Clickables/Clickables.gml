global.clickable_hovered = noone;
global.clickable_dragged = noone;

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

function clickables_update() {
	with (obj_draggable) {
		if (mouse_check_button_released(mb_left)) {
			global.clickable_dragged = noone;
			var position_close = noone;
			with (obj_draggable_position) {
				if (distance_to_point(mouse_x, mouse_y) < 100) position_close = id;
			}
			if (position_close != noone) {
				show_debug_message($"{id} released close to {position_close}");
				x = position_close.x;
				y = position_close.y;
			}
			on_release();
		}
	}
	
	if (global.clickable_dragged != noone) return;
	
	var clickable_ids = __clickables_get_all();
	array_foreach(clickable_ids, function(clickable_id) {
		with (clickable_id) {
			if (global.clickable_hovered == noone) {
				if (position_meeting(mouse_x, mouse_y, id)) global.clickable_hovered = id;
				if (clickable_id.disabled) return;
				if (mouse_check_button_pressed(mb_left) && global.clickable_hovered == id) on_click();
			}
		}
	});
}

global.clickable_blackout_alpha = 0;

function clickables_draw() {
	draw_set_alpha(1);
	var clickable_ids = __clickables_get_all();
	array_foreach(array_reverse(clickable_ids), function(clickable_id) {
		with (clickable_id) {
			pre_draw();
			draw();
			if (global.clickable_hovered == id && !clickable_id.disabled) {
				shader_set(sh_hovered);
				draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, 1);
				shader_reset();
			}
		}
	});
}
