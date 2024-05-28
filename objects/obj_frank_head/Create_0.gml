event_inherited();

on_click = function() {
	if (!global.frank_memory_chip_added) {
		global.updateable = dialog_get_updateable([
			global.frank_get_dialog_step("It's me!", FRANK_EXPRESSION.HAPPY),
		]);
	} else if (!global.frank_attached_head) {
		global.frank_attached_head = true;
		disabled = true;
		global.updateable = {
			step: 0,
			time: 0,
			steps: [
				function() {
					if (time > 60) global.updateable = dialog_get_updateable([
						frank_get_dialog_step("Yes", FRANK_EXPRESSION.HAPPY),
						frank_get_dialog_step("Much better.", FRANK_EXPRESSION.RIGHT),
						frank_get_dialog_step("I can see the room better now.", FRANK_EXPRESSION.NEUTRAL),
					]);
				},
			],
			update: function() {
				time += 1;
				steps[step]();
			}
		};
	}
};

original_draw = draw;

draw = function () {
	if (global.frank_attached_head) return;
	if (!global.light_switch_on) image_index = 1;
	original_draw();
	frank_draw_expression();
};
