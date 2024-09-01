event_inherited();

on_click = function() {
	if (!global.frank_memory_chip_added) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("Canisters of film and workshop parts.", CORY_EXPRESSION.BOTH_WINGS),
			cory_get_dialog_step("Frank, do you remember what film this was?", CORY_EXPRESSION.TAP),
			frank_get_dialog_step("Right now I don't remember what a \"film\" is.", FRANK_EXPRESSION.UNAMUSED),
			cory_get_dialog_step("Ah...", CORY_EXPRESSION.NEUTRAL),
		]);
	} else {
		global.updateable = dialog_get_updateable([
			frank_get_dialog_step("Ah! I remember now.", FRANK_EXPRESSION.BLANK),
			frank_get_dialog_step("These are the reels we’ll use for the story machine!", FRANK_EXPRESSION.RIGHT),
		]);
	}
};
