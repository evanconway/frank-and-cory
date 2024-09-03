event_inherited();

on_click = function() {
	if (global.frank_memory_chip_added) {
		global.updateable = dialog_get_updateable([
			frank_get_dialog_step("Oh right!", FRANK_EXPRESSION.NEUTRAL),
			frank_get_dialog_step("I made this.", FRANK_EXPRESSION.RIGHT),
			frank_get_dialog_step("It's a carving of you Cory!", FRANK_EXPRESSION.HAPPY),
			cory_get_dialog_step("The resemblence is uncanny.", CORY_EXPRESSION.BOTH_WINGS),
		]);
	} else {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("That looks like me!", CORY_EXPRESSION.SALUTE),
			frank_get_dialog_step("I wonder where that came from.", FRANK_EXPRESSION.RIGHT),
		]);
	}
};
