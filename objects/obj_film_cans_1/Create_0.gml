event_inherited();

on_click = function() {
	if (!global.frank_memory_chip_added) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("Canisters of film and workshop parts.", CORY_EXPRESSION.HAPPY),
			cory_get_dialog_step("Frank, do you remember what film this was?", CORY_EXPRESSION.NEUTRAL),
			frank_get_dialog_step("Right now I don't think I even remember what a \"film\" is.", FRANK_EXPRESSION.UNAMUSED),
			cory_get_dialog_step("Ah...", CORY_EXPRESSION.UNAMUSED),
		]);
	} else {
		global.updateable = dialog_get_updateable([
			frank_get_dialog_step("Ah! I remember now.", FRANK_EXPRESSION.BLANK),
			frank_get_dialog_step("This was a documentary on REPLACE WITH SOMETHING JUDE THINKS IS COOL.", FRANK_EXPRESSION.RIGHT),
		]);
	}
};
