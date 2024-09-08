event_inherited();

chastised = false

on_click = function() {
	if (!global.frank_memory_chip_added) {
		global.updateable = dialog_get_updateable([
			frank_get_dialog_step("Who left these out?", FRANK_EXPRESSION.RIGHT),
			cory_get_dialog_step("You did, remember?", CORY_EXPRESSION.BOTH_WINGS),
			frank_get_dialog_step("Hmm, we really need to find this chip.", FRANK_EXPRESSION.UNAMUSED),
		]);
	} else if (!chastised) {
		chastised = true;
		global.updateable = dialog_get_updateable([
			frank_get_dialog_step("Now I remember.", FRANK_EXPRESSION.UP),
			frank_get_dialog_step("You DID leave these out.", FRANK_EXPRESSION.RIGHT),
			cory_get_dialog_step("I did? Oh, sorry.", CORY_EXPRESSION.SALUTE),
		]);
	} else {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("We can put these away later.", CORY_EXPRESSION.TAP),
		]);
	}
};
