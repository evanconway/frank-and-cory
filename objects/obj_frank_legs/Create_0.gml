event_inherited();

on_click = function() {
	if (!global.frank_memory_chip_added) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("Frank...", CORY_EXPRESSION.TAP),
			cory_get_dialog_step("Why did you put your own legs on the highest shelf?", CORY_EXPRESSION.BOTH_WINGS),
			frank_get_dialog_step("What's a \"shelf\"?", FRANK_EXPRESSION.NEUTRAL),
			cory_get_dialog_step("We need you fixed ASAP!", CORY_EXPRESSION.SALUTE),
		]);
	} else if (!global.frank_attached_arms) {
		global.updateable = dialog_get_updateable([
			frank_get_dialog_step("I'm not ready for those yet.", FRANK_EXPRESSION.NEUTRAL),
		]);
	} else {
		disabled = true;
		visible = false;
		play_sfx(snd_button);
		global.frank_attached_legs = true;
		global.updateable = dialog_get_updateable([
			frank_get_dialog_step("LEGS", FRANK_EXPRESSION.BLANK),
		]);
	}
};
