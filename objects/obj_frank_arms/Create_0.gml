event_inherited();

original_draw = draw;

draw = function() {
	visible = !global.frank_attached_arms;
	original_draw();
};

on_click = function() {
	if (!global.frank_memory_chip_added) {
		global.updateable = dialog_get_updateable([
			global.frank_get_dialog_step("Those are my arms!", FRANK_EXPRESSION.UP),
			global.frank_get_dialog_step("But I don't think we're ready for those yet.", FRANK_EXPRESSION.UNAMUSED),
		]);
	} else {
		global.frank_attached_arms = true;
		play_sfx(snd_button);
		global.updateable = dialog_get_updateable([
			global.frank_get_dialog_step("Ah!", FRANK_EXPRESSION.NEUTRAL),
			global.frank_get_dialog_step("That's better.", FRANK_EXPRESSION.HAPPY),
		]);
	}
};
