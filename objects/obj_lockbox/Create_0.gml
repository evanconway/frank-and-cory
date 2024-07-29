event_inherited();

box_state = "locked";

on_click = function() {
	if (box_state == "open") {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("I think this is your chip Frank.", CORY_EXPRESSION.TAP),
			frank_get_dialog_step("Let's hope so.", FRANK_EXPRESSION.DOWNLEFT),
		], {
			after_dialog_updateable:  {
				update: function() {
					play_sfx(snd_button);
					obj_lockbox.box_state = "empty";
					obj_lockbox.disabled = true;
					global.memory_cursor = true;
					global.updateable = undefined;
				},
			}
		});
	} else if (box_state == "locked" && global.key_cursor) {
		global.key_cursor = false;
		play_sfx(snd_jude_key_jingle);
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
							cory_get_dialog_step("We opened the box!", CORY_EXPRESSION.SALUTE),
							frank_get_dialog_step("Hey. That chip looks familiar...", FRANK_EXPRESSION.UP),
						]);
					}
				}
			],
			update: function() {
				time += 1;
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
