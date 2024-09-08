// feather ignore GM1043

global.credits = {
	alpha: 0,
	fade_alpha: 0,
	time: 0,
	step: 0,
	get_text: function(new_text="_") {
		return new TagDecoratedTextDefault(new_text, "f:fnt_ally black");
	},
	text: new TagDecoratedTextDefault("Art by Allison Conway", "f:fnt_ally black"),
	play_again_text: undefined,
	steps: [
		function() {
			if (time >= 150) {
				time = 0;
				step += 1;
			}
		},
		function() {
			alpha += 0.01;
			if (alpha >= 1) {
				time = 0;
				step += 1;
			}
		},
		function() {
			if (time >= 300) {
				time = 0;
				step += 1;
			}
		},
		function() {
			alpha -= 0.01;
			if (alpha <= 0) {
				text = get_text("Story and characters by Jude Brewer");
				time = 0;
				step += 1;
			}
		},
		function() {
			alpha += 0.01;
			if (alpha >= 1) {
				time = 0;
				step += 1;
			}
		},
		function() {
			if (time >= 300) {
				time = 0;
				step += 1;
			}
		},
		function() {
			alpha -= 0.01;
			if (alpha <= 0) {
				text = get_text("Programming by Evan Conway");
				time = 0;
				step += 1;
			}
		},
		function() {
			alpha += 0.01;
			if (alpha >= 1) {
				time = 0;
				step += 1;
			}
		},
		function() {
			if (time >= 300) {
				time = 0;
				step += 1;
			}
		},
		function() {
			alpha -= 0.01;
			if (alpha <= 0) {
				text = get_text("Thank you for playing!");
				time = 0;
				step += 1;
			}
		},
		function() {
			alpha += 0.01;
			if (alpha >= 1) {
				time = 0;
				step += 1;
			}
		},
		function() {
			if (time >= 200) {
				time = 0;
				step += 1;
				play_again_text = new TagDecoratedTextDefault("Click to play again.", "f:fnt_ally black fade");
			}
		},
		function() {
			if (mouse_check_button_pressed(mb_any)) {
				step += 1;
				time = 0;
			}
		},
		function() {
			fade_alpha += 0.01;
			if (fade_alpha >= 1) {
				global.credits.alpha = 0;
				global.credits.fade_alpha = 0;
				global.credits.time = 0;
				global.credits.step = 0;
				global.credits.text = new TagDecoratedTextDefault("Art by Allison Conway", "f:fnt_ally black");
				global.credits.play_again_text = undefined;
				reset_game();
			}
		},
	],
	update: function() {
		time += 1;
		steps[step]();
	},
	draw: function() {
		draw_set_alpha(alpha);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		tag_decorated_text_draw(text, display_get_gui_width() / 2, display_get_gui_height() / 2);
		if (play_again_text != undefined) {
			tag_decorated_text_draw(play_again_text, display_get_gui_width() / 2, display_get_gui_height() / 2 + 400);
		}
		draw_set_alpha(fade_alpha);
		draw_set_color(c_black);
		draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
	},
}