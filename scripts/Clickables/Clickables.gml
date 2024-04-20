global.clickable_hovered = noone;

function __clickables_get_all() {
	var clickable_ids = [];
	with (obj_clickable) {
		array_push(clickable_ids, id);
	}
	array_sort(clickable_ids, function(id_a, id_b) {
		return id_a.depth - id_b.depth;
	})
	return clickable_ids;
}

function clickables_update() {
	global.clickable_hovered = noone;
	var clickable_ids = __clickables_get_all();
	array_foreach(clickable_ids, function(clickable_id) {
		with (clickable_id) {
			if (clickable_id.disabled) return;
			if (global.clickable_hovered == noone) {
				if (position_meeting(mouse_x, mouse_y, id)) global.clickable_hovered = id;
				if (mouse_check_button_pressed(mb_any) && global.clickable_hovered == id) on_click();
			}
		}
	});
}

function clickables_draw() {
	var clickable_ids = __clickables_get_all();
	array_foreach(array_reverse(clickable_ids), function(clickable_id) {
		with (clickable_id) {
			pre_draw();
			draw();
			if (global.clickable_hovered == id) {
				shader_set(sh_hovered);
				draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, 1);
				shader_reset();
			}
		}
	});
}