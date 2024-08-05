event_inherited();

on_click = function() {
	var frank_is_assembled = global.frank_attached_arms && global.frank_attached_head && global.frank_attached_legs;
	if (frank_is_assembled) {
		play_sfx(snd_button);
		global.updateable = {
			time: 0,
			update: function() {
				time += 1;
				if (time >= 60) {
					podcast_machine_transition();
				}
			}
		}
	} else {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("This is the lever to activate the story machine.", CORY_EXPRESSION.BOTH_WINGS),
			cory_get_dialog_step("But we're not ready for it yet.", CORY_EXPRESSION.TILT),
		]);
	}
};
