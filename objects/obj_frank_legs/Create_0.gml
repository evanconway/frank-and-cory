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
		image_index = 1; // change to empty sprite to invisible legs don't block clickable area
		play_sfx(snd_jude_attach_legs);
		global.frank_attached_legs = true;
		global.frank_dialog_position = FRANK_DIALOG_POSITION.ASSEMBLED_FULL;
		global.updateable = {
			time: 0,
			update: function() {
				time += 1;
				if (time >= 60) {
					global.updateable = dialog_get_updateable([
						frank_get_dialog_step("Ow!", FRANK_EXPRESSION.BLANK),
						cory_get_dialog_step("Oops.", CORY_EXPRESSION.SALUTE),
						cory_get_dialog_step("How's that?", CORY_EXPRESSION.BOTH_WINGS),
						frank_get_dialog_step("Not bad!", FRANK_EXPRESSION.HAPPY),
						frank_get_dialog_step("Thanks, buddy.", FRANK_EXPRESSION.RIGHT),
						frank_get_dialog_step("Now pull the lever to activate the story machine!", FRANK_EXPRESSION.HAPPY),
					]);
				}
			}
		}
	}
};

draw = function() {
	if (visible) draw_self();
};
