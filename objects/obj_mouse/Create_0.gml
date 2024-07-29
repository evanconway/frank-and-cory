event_inherited();

// not sure why it's making a warning here
// feather disable GM1043
global.mouse_fetch_chip = {
	time: 0,
	step: 0,
	steps: [
		function() {
			if (time >= 60) {
				time = 0;
				obj_mouse.image_index = 2;
				play_sfx(snd_jude_mouse_squeak);
				step++;
			}
		},
		function() {
			obj_mouse.image_index = 2;
			if (time >= 45) {
				time = 0;
				obj_mouse.visible = false;
				play_sfx(snd_jude_mouse_run_1);
				step++;
			}
		},
		function() {
			obj_mouse.visible = false;
			if (time >= 45) {
				time = 0;
				obj_mouse.visible = true;
				obj_mouse.image_index = 2;
				play_sfx(snd_jude_mouse_run_2);
				step++;
			}
		},
		function() {
			obj_mouse.image_index = 2;
			if (time >= 45) {
				time = 0;
				obj_mouse.image_index = 1;
				play_sfx(snd_jude_key_jingle);
				step++;
			}
		},
		function() {
			obj_mouse.image_index = 1;
			if (time >= 80) {
				time = 0;
				global.updateable = dialog_get_updateable([
				cory_get_dialog_step("That's a key!", CORY_EXPRESSION.SALUTE),
					cory_get_dialog_step("Thank you mouse!", CORY_EXPRESSION.BOTH_WINGS),
				], {
					on_step_all: function() {
						obj_mouse.image_index = 1;
					},
					after_dialog_updateable: {
						update: function() {
							global.key_cursor = true;
							global.updateable = undefined;
						}
					},
				});
			}
		}
	],
	update: function() {
		time += 1;
		steps[step]();
	},
};

on_click = function() {
	if (global.chip_cursor && global.chip_taken) {
		global.chip_cursor = false;
		play_sfx(snd_jude_chomp);
		global.updateable = global.mouse_fetch_chip;
	} else if (!global.chip_cursor && global.chip_taken) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("What a generous mouse.", CORY_EXPRESSION.NEUTRAL),
		]);
	} else {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("What a cute mouse!", CORY_EXPRESSION.TILT),
			cory_get_dialog_step("It looks hungry.", CORY_EXPRESSION.SALUTE),
		]);
	}
};
