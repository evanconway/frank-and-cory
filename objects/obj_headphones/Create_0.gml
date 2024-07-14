event_inherited();

on_click = function() {
	global.updateable = dialog_get_updateable([
		cory_get_dialog_step("We'll need these later, not right now.", CORY_EXPRESSION.SALUTE),
	]);
};
