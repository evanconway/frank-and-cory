event_inherited();

on_click = function() {
	if (global.chip_cursor) {
		global.chip_cursor = false;
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("It ate the chip!", CORY_EXPRESSION.SALUTE),
			cory_get_dialog_step("And now it'll get the key!", CORY_EXPRESSION.BOTH_WINGS),
		]);
	} else {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("It looks hungry.", CORY_EXPRESSION.SALUTE),
		]);
	}
};
