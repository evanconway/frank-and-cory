event_inherited();

disabled = true;

original_draw = draw;

draw = function() {
	original_draw();
	draw_set_alpha(1)
	draw_sprite(spr_desk_lamp_light, 0, 0, 0);
};
