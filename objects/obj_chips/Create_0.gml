event_inherited();

chips_eaten = 0;

set_chips_dialog = function() {
	if (chips_eaten == 1) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("Yum!", CORY_EXPRESSION.SALUTE),
			cory_get_dialog_step("I want another.", CORY_EXPRESSION.BOTH_WINGS),
		]);
	} else if (chips_eaten == 2) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("Okay... maybe one more.", CORY_EXPRESSION.TAP),
		]);
	} else if (chips_eaten == 3) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("Okay. One more then I'm done.", CORY_EXPRESSION.BOTH_WINGS),
			cory_get_dialog_step("Last one. I promise.", CORY_EXPRESSION.SALUTE),
		]);
	} else if (chips_eaten == 4) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("All right I admit it.", CORY_EXPRESSION.SALUTE),
			cory_get_dialog_step("I want one more...", CORY_EXPRESSION.TILT),
		]);
	} else if (chips_eaten == 5) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("Actually...", CORY_EXPRESSION.TAP),
			cory_get_dialog_step("Maybe someone else should have this.", CORY_EXPRESSION.SALUTE),
		], {
			after_dialog_updateable: {
				update: function() {
					global.chip_cursor = true;
					global.chip_taken = true;
					obj_chips.image_index = 5;
					global.updateable = undefined;
				}
			}
		});
	} else {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("ERROR. This dialog should not appear. obj_chips"),
		]);
	}
}

on_click = function() {
	if (chips_eaten >= 5) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("No more for me.", CORY_EXPRESSION.TAP),
		]);
		disabled = true;
		return;
	}
	
	chips_eaten += 1;
	
	if (chips_eaten < 5) {
		play_sfx(snd_jude_chomp);
	}
	
	with (obj_chips) {
		if (image_index < 4) image_index += 1;
	}
	global.updateable = {
		set_chips_dialog,
		time: 0,
		update: function() {
			time += 1;
			if (time >= 45) set_chips_dialog();
		},
	}
};

draw = function() {
	if (global.chip_taken) image_index = 5;
	if (visible) draw_self();
	visible = true;
};
