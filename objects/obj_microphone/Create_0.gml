event_inherited();

alternate = false;

on_click = function() {
	alternate = !alternate;
	if (alternate) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("Is this thing even on?", CORY_EXPRESSION.TAP),
		]);
	} else {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("Testing, 1, 2, 3.", CORY_EXPRESSION.BOTH_WINGS),
		]);
	}
};
