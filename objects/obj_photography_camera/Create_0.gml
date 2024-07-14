event_inherited();

photos_taken = 0;

set_photo_dialog = function() {
	if (photos_taken == 1) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("Nice picture!", CORY_EXPRESSION.BOTH_WINGS),
			cory_get_dialog_step("Kind of a boring pose from that spider, though.", CORY_EXPRESSION.TAP),
		]);
	} else if (photos_taken == 2) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("Another picture... same boring pose.", CORY_EXPRESSION.TAP),
		]);
	} else if (photos_taken == 3) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("Yup. Another boring pose.", CORY_EXPRESSION.BOTH_WINGS),
		]);
	} else if (photos_taken == 4) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("Really?", CORY_EXPRESSION.SALUTE),
		]);
	} else {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("ERROR. This dialog should not appear. obj_photography_camera"),
		]);
	}
}

on_click = function() {
	if (photos_taken >= 4) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("It's out of film now.", CORY_EXPRESSION.SALUTE),
		]);
		disabled = true;
		return;
	}
	photos_taken += 1;
	play_sfx(snd_button);
	global.updateable = {
		set_photo_dialog,
		alpha: 0.75,
		update: function() {
			alpha -= 0.015;
			if (alpha <= 0) set_photo_dialog()
		},
		draw: function() {
			draw_set_color(c_white);
			draw_set_alpha(alpha);
			draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
		}
	}
};
