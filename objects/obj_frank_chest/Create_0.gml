event_inherited();

on_click = function() {
	if (!global.frank_memory_chip_added) {
		global.updateable = dialog_get_updateable([
			frank_get_dialog_step("Wow.", FRANK_EXPRESSION.UP),
			frank_get_dialog_step("What a stupid-looking machine.", FRANK_EXPRESSION.HAPPY),
			cory_get_dialog_step("Frank.", CORY_EXPRESSION.TILT),
			cory_get_dialog_step("That's your own body.", CORY_EXPRESSION.TAP),
			frank_get_dialog_step("Oh...", FRANK_EXPRESSION.UNAMUSED),
		]);
	} else if (!global.frank_attached_head) {
		global.updateable = dialog_get_updateable([
			frank_get_dialog_step("Sure would be nice to have a body again.", FRANK_EXPRESSION.UP),
		]);
	} else if (!global.frank_attached_legs) {
		global.updateable = dialog_get_updateable([
			frank_get_dialog_step("Now if I could just get mobile again...", FRANK_EXPRESSION.BLANK),
		]);
	} else {
		global.updateable = dialog_get_updateable([
			frank_get_dialog_step("How do I look?", FRANK_EXPRESSION.RIGHT),
			cory_get_dialog_step("Frankly?", CORY_EXPRESSION.TAP),
			frank_get_dialog_step("Huh?", FRANK_EXPRESSION.BLANK),
			cory_get_dialog_step("You look very...", CORY_EXPRESSION.TILT),
			cory_get_dialog_step("Frank", CORY_EXPRESSION.BOTH_WINGS),
		]);
	}
};

draw = function() {
	if (global.frank_attached_legs) {
		image_index = 2;
		draw_self();
		frank_draw_expression(x - 93, y - 1540, x - 123, y - 1494);
	} else if (global.frank_attached_head) {
		image_index = 1;
		draw_self();
		frank_draw_expression(x + 393, y - 1496, x + 384, y - 1453);
	} else {
		image_index = 0;
		draw_self();
	}
};
