// feather ignore GM1043

get_text = function(new_text="_") {
	return new TagDecoratedTextDefault(new_text, "f:fnt_ally black");
};

global.updateable = {
	alpha: 0,
	time: 0,
	step: 0,
	get_text,
	text: get_text("Art by Allison Conway"),
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
			if (mouse_check_button_pressed(mb_any)) game_restart();
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
	},
}