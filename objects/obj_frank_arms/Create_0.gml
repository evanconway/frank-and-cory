event_inherited();

on_click = function() {
	global.updateable = dialog_get_updateable([
		global.frank_get_dialog_step("Those are my arms!", FRANK_EXPRESSION.UP),
	]);
};
