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
		global.updateable = {
			time: 0,
			update: function() {
				time += 1;
				if (time >= 60) {
					global.updateable = dialog_get_updateable([
						frank_get_dialog_step("Ah...", FRANK_EXPRESSION.HAPPY),
						cory_get_dialog_step("How's that?", CORY_EXPRESSION.BOTH_WINGS),
						frank_get_dialog_step("Not bad!", FRANK_EXPRESSION.RIGHT),
						frank_get_dialog_step("I feel like my old self again!", FRANK_EXPRESSION.DOWNLEFT),
						frank_get_dialog_step("Thanks, buddy.", FRANK_EXPRESSION.RIGHT),
						frank_get_dialog_step("Now let's activate the story machine!", FRANK_EXPRESSION.HAPPY),
						cory_get_dialog_step("You got it!", CORY_EXPRESSION.SALUTE),
					], {
						after_dialog_updateable: {
							update: function() {
								global.updateable = undefined;
								podcast_machine_transition();
							}
						}
					});
				}
			}
		}
	}
};

draw = function() {
	if (visible) draw_self();
};
