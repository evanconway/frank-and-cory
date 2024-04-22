event_inherited();

on_click = function() {
	global.updateable = dialog_get_updateable([
		"Wow you just clicked on my head!",
		"Hopefully now you see dialog.",
		"This should help us setup the rest of the game.",
	]);
};

original_draw = draw;

draw = function () {
	if (!global.light_switch_on) image_index = 1;
	original_draw();
	draw_set_alpha(1);
	draw_set_color(c_white);
	if (global.frank_expression == FRANK_EXPRESSION.GLOSSY) draw_sprite(spr_frank_eyes, 4, 0, 0);
	if (global.frank_expression == FRANK_EXPRESSION.HAPPY) draw_sprite(spr_frank_eyes, 1, 0, 0);
	if (global.frank_expression == FRANK_EXPRESSION.NEUTRAL) draw_sprite(spr_frank_eyes, 0, 0, 0);
	if (global.frank_expression == FRANK_EXPRESSION.RIGHT) draw_sprite(spr_frank_eyes, 2, 0, 0);
	if (global.frank_expression == FRANK_EXPRESSION.UNAMUSED) draw_sprite(spr_frank_eyes, 5, 0, 0);
	if (global.frank_expression == FRANK_EXPRESSION.UP) draw_sprite(spr_frank_eyes, 3, 0, 0);
};
