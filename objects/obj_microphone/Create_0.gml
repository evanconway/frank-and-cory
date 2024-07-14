event_inherited();

on_click = function() {
	global.updateable = dialog_get_updateable([
		cory_get_dialog_step("Is this thing even on?", CORY_EXPRESSION.TAP),
	]);
};
