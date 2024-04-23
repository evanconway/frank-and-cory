event_inherited();

on_click = function() {
	global.updateable = dialog_get_updateable([
		"Wow you just clicked on my head!",
		"Hopefully now you see dialog.",
		"This should help us setup the rest of the game.",
	]);
};

original_draw = draw;

idle_expression_options = [FRANK_EXPRESSION.NEUTRAL, FRANK_EXPRESSION.RIGHT, FRANK_EXPRESSION.UP];
idle_expression = FRANK_EXPRESSION.NEUTRAL;
idle_time = 60;

draw = function () {
	// organic facial changes while nothing active
	if (global.updateable == undefined) {
		idle_time -= 1;
		if (idle_time < 0) {
			idle_time = irandom_range(60, 120);
			var options = array_filter(idle_expression_options, method({ idle_expression }, function(option) {
				return option != idle_expression
			}))
			idle_expression = options[irandom_range(0, array_length(options) - 1)];
		}
		global.frank_expression = idle_expression;
	}
	
	if (!global.light_switch_on) image_index = 1;
	original_draw();
	draw_set_alpha(1);
	draw_set_color(c_white);
	if (global.frank_expression == FRANK_EXPRESSION.NEUTRAL) draw_sprite(spr_frank_eyes, 4, 0, 0);
	if (global.frank_expression == FRANK_EXPRESSION.HAPPY) draw_sprite(spr_frank_eyes, 1, 0, 0);
	if (global.frank_expression == FRANK_EXPRESSION.BLANK) draw_sprite(spr_frank_eyes, 0, 0, 0);
	if (global.frank_expression == FRANK_EXPRESSION.RIGHT) draw_sprite(spr_frank_eyes, 2, 0, 0);
	if (global.frank_expression == FRANK_EXPRESSION.UNAMUSED) draw_sprite(spr_frank_eyes, 5, 0, 0);
	if (global.frank_expression == FRANK_EXPRESSION.UP) draw_sprite(spr_frank_eyes, 3, 0, 0);
};
