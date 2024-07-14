event_inherited();

global.mouse_fetch_chip = {
	time: 0,
	step: 0,
	steps: [
		function() {
			if (time >= 45) {
				time = 0;
				obj_mouse.visible = false;
				play_sfx(snd_button);
				step++;
			}
		},
		function() {
			obj_mouse.visible = false;
			if (time >= 45) {
				time = 0;
				obj_mouse.visible = true;
				play_sfx(snd_button);
				step++;
			}
		},
		function() {
			if (time >= 45) {
				time = 0;
				global.updateable = dialog_get_updateable([
					cory_get_dialog_step("Hey thanks!", CORY_EXPRESSION.BOTH_WINGS),
				], {
					after_dialog_updateable: {
						update: function() {
							global.key_cursor = true;
							global.updateable = undefined;
						}
					},
					pre_dialog_draw: function() {
						draw_sprite(spr_key, 0, 1000, 1000);
					}
				});
			}
		}
	],
	update: function() {
		time += 1;
		steps[step]();
	},
	draw: function() {
		if (step != 2) return;
		draw_sprite(spr_key, 0, 1000, 1000);
	}
};

on_click = function() {
	if (global.chip_cursor && global.chip_taken) {
		global.chip_cursor = false;
		play_sfx(snd_button);
		global.updateable = global.mouse_fetch_chip;
	} else if (!global.chip_cursor && global.chip_taken) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("What a generous mouse.", CORY_EXPRESSION.NEUTRAL),
		]);
	} else {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("It looks hungry.", CORY_EXPRESSION.SALUTE),
		]);
	}
};
