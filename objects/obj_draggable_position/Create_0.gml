event_inherited();

if (!ds_map_exists(global.position_draggable_map, id)) {
	ds_map_set(global.position_draggable_map, id, noone);
}

draw = function() {
	if (!visible) return;
	draw_set_alpha(1);
	draw_self();
};
