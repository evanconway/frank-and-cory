event_inherited();

box_state = "locked";

on_click = function() {
	if (box_state == "open") {
		play_sfx(snd_button);
		obj_lockbox.box_state = "empty";
		obj_lockbox.disabled = true;
		global.memory_cursor = true;
	} else if (box_state == "locked" && global.key_cursor) {
		global.key_cursor = false;
		play_sfx(snd_jude_box_unlock);
		// feather ignore GM1043
		global.updateable = {
			time: 0,
			step: 0,
			steps: [
				function() {
					if (time >= 60) {
						time = 0;
						step += 1;
						play_sfx(snd_button);
						obj_lockbox.box_state = "open";
					}
				},
				function() {
					if (time >= 45) {
						global.updateable = dialog_get_updateable([
							cory_get_dialog_step("Frank! It's your chip!", CORY_EXPRESSION.BOTH_WINGS),
							frank_get_dialog_step("Can I eat chips?", FRANK_EXPRESSION.UP),
							cory_get_dialog_step("Your memory chip!", CORY_EXPRESSION.SALUTE),
							frank_get_dialog_step("Oh, right. I forgot what we were doing.", FRANK_EXPRESSION.UNAMUSED),
						]);
					}
				}
			],
			update: function() {
				time += (delta_time / global.frame_time);
				steps[step]();
			},
		}
	} else {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("It's locked.", CORY_EXPRESSION.BOTH_WINGS),
			cory_get_dialog_step("What could be in here?", CORY_EXPRESSION.SALUTE),
			frank_get_dialog_step("...", FRANK_EXPRESSION.BLANK),
		]);
	}
};

draw = function() {
	if (box_state == "locked") image_index = 0;
	if (box_state == "open") image_index = 1;
	if (box_state == "empty") image_index = 2;
	draw_self();
};
