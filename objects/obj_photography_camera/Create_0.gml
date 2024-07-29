event_inherited();

photos_taken = 0;
global.spider_pose = 0;

set_photo_dialog = function() {
	if (photos_taken == 1) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("Nice picture!", CORY_EXPRESSION.BOTH_WINGS),
			cory_get_dialog_step("Can we get a different pose?", CORY_EXPRESSION.TAP),
		], {
			after_dialog_updateable: {
				update: function() {
					play_sfx(snd_jude_mouse_run_1);
					global.spider_pose = 1;
					global.updateable = undefined;
				},
			},
		});
	} else if (photos_taken == 2) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("Even better.", CORY_EXPRESSION.TAP),
			cory_get_dialog_step("But what about something more...", CORY_EXPRESSION.TILT),
			cory_get_dialog_step("Dynamic?", CORY_EXPRESSION.SALUTE),
		], {
			after_dialog_updateable: {
				update: function() {
					play_sfx(snd_jude_mouse_run_1);
					global.spider_pose = 2;
					global.updateable = undefined;
				},
			},
		});
	} else if (photos_taken == 3) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("That's more like it!", CORY_EXPRESSION.BOTH_WINGS),
		]);
	} else {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("ERROR. This dialog should not appear. obj_photography_camera"),
		]);
	}
}

on_click = function() {
	if (photos_taken >= 3) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("It's out of film now.", CORY_EXPRESSION.SALUTE),
		]);
		disabled = true;
		return;
	}
	photos_taken += 1;
	play_sfx(snd_jude_camera);
	
	// feather ignore GM1043
	global.updateable = {
		set_photo_dialog,
		alpha: 0,
		step: 0,
		time: 0,
		steps: [
			function() {
				// beep time
				obj_photography_camera.image_index = 1;
				if (time >= 20) {
					step++;
					alpha = 0.75;
				}
			},
			function () {
				// flash
				alpha -= 0.015;
				if (alpha <= 0) set_photo_dialog()
			},
		],
		update: function() {
			time += 1;
			steps[step]();
		},
		draw: function() {
			draw_set_color(c_white);
			draw_set_alpha(alpha);
			draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
		}
	}
};
