event_inherited();

box_opened = false;

on_click = function() {
	if (box_opened) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("We don't need that box anymore.", CORY_EXPRESSION.SALUTE),
		]);
	} else if (global.key_cursor) {
		global.key_cursor = false;
		box_opened = true;
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("We opened the box!", CORY_EXPRESSION.SALUTE),
		]);
	} else {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("It's locked.", CORY_EXPRESSION.BOTH_WINGS),
			cory_get_dialog_step("What could be in here?", CORY_EXPRESSION.SALUTE),
			frank_get_dialog_step("...", FRANK_EXPRESSION.BLANK),
		]);
	}
};
