event_inherited();

on_click = function() {
	global.updateable = dialog_get_updateable([
		cory_get_dialog_step("It looks hungry.", CORY_EXPRESSION.SALUTE),
	]);
};
