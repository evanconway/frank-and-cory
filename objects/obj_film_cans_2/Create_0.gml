event_inherited();

on_click = function() {
	global.updateable = dialog_get_updateable([
		cory_get_dialog_step("Wow.", CORY_EXPRESSION.SALUTE),
		cory_get_dialog_step("We sure do have a lot of film canisters around here.", CORY_EXPRESSION.NEUTRAL),
	]);
};
