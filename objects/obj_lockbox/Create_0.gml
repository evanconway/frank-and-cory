event_inherited();

on_click = function() {
	global.updateable = dialog_get_updateable([
		cory_get_dialog_step("It's locked.", CORY_EXPRESSION.BOTH_WINGS),
		cory_get_dialog_step("What could be in here?", CORY_EXPRESSION.SALUTE),
		frank_get_dialog_step("...", FRANK_EXPRESSION.BLANK),
	]);
};
