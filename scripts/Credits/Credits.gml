// feather ignore GM1043

global.credits = {
	alpha: 0,
	fade_alpha: 0,
	time: 0,
	step: 0,
	get_text: function(new_text="_") {
		return new TagDecoratedTextDefault(new_text, "f:fnt_ally black", 1900);
	},
	text: new TagDecoratedTextDefault("Art by Allison Conway", "f:fnt_ally black"),
	play_again_text: undefined,
	steps: [
		function() {
			if (time >= 60 * 14) {
				time = 0;
				step += 1;
			}
		},
		function() {
			alpha += (0.01 * (delta_time / global.frame_time));
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
			alpha -= (0.01 * (delta_time / global.frame_time));
			if (alpha <= 0) {
				text = get_text("Characters, story, and sound design by Jude Brewer");
				time = 0;
				step += 1;
			}
		},
		function() {
			alpha += (0.01 * (delta_time / global.frame_time));
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
			alpha -= (0.01 * (delta_time / global.frame_time));
			if (alpha <= 0) {
				text = get_text("Cory's story music by John Fio");
				time = 0;
				step += 1;
			}
		},
		function() {
			alpha += (0.01 * (delta_time / global.frame_time));
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
			alpha -= (0.01 * (delta_time / global.frame_time));
			if (alpha <= 0) {
				text = get_text("Programming and music by Evan Conway");
				time = 0;
				step += 1;
			}
		},
		function() {
			alpha += (0.01 * (delta_time / global.frame_time));
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
			alpha -= (0.01 * (delta_time / global.frame_time));
			if (alpha <= 0) {
				text = get_text("Thank you for playing!");
				time = 0;
				step += 1;
			}
		},
		function() {
			alpha += (0.01 * (delta_time / global.frame_time));
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
			alpha -= (0.01 * (delta_time / global.frame_time));
			if (alpha <= 0) {
				time = 0;
				step += 1;
				play_again_text = new TagDecoratedTextDefault("Click to play again.", "f:fnt_ally white fade");
			}
		},
		function() {
			if (mouse_check_button_pressed(mb_any)) {
				step += 1;
				time = 0;
			}
		},
		function() {
			fade_alpha += (0.01 * (delta_time / global.frame_time));
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
	ripple_time: 0,
	update: function() {
		time += (delta_time / global.frame_time);
		steps[step]();
		ripple_time += (0.7 * (delta_time / global.frame_time));
	},
	get_ripple_alpha: function(time_offset=0) {
		var fade_time = 60 * 6;
		var overlap_time = 60 * 0.5;
		var total_time = fade_time * 3 - (overlap_time * 3);
		
		// we add overlap_time so the animation doesn't start on an overlap
		var unique_time = (ripple_time + time_offset + fade_time / 2) % total_time;
		if (unique_time <= fade_time / 2) return unique_time / (fade_time / 2);
		if (unique_time <= fade_time) return 1 - ((unique_time - fade_time / 2) / (fade_time / 2));
		return 0;
	},
	draw: function() {
		// water
		draw_sprite_ext(spr_water_ripples, 0, 0, 0, 1, 1, 0, c_white, get_ripple_alpha(60 * 0));
		draw_sprite_ext(spr_water_ripples, 1, 0, 0, 1, 1, 0, c_white, get_ripple_alpha(60 * 5.5));
		draw_sprite_ext(spr_water_ripples, 2, 0, 0, 1, 1, 0, c_white, get_ripple_alpha(60 * 11));
		draw_sprite_ext(spr_finale_frank, 0, 0, 0, 1, 1, 0, c_white, 1);
		draw_sprite_ext(spr_finale_cory, 0, 0, 0, 1, 1, 0, c_white, 1);
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_sprite_ext(spr_brush_stroke, 0, display_get_gui_width() / 2, display_get_gui_height() / 2, 1, 1, 0, c_white, alpha);
		draw_set_alpha(alpha);
		tag_decorated_text_draw(text, display_get_gui_width() / 2, display_get_gui_height() / 2);
		if (play_again_text != undefined) {
			draw_set_alpha(1);
			draw_set_halign(fa_left);
			draw_set_valign(fa_bottom);
			tag_decorated_text_update(play_again_text, delta_time / 1000);
			tag_decorated_text_draw_no_update(play_again_text, 50, display_get_gui_height() - 50);
		}
		
		draw_set_alpha(fade_alpha);
		draw_set_color(c_black);
		draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
	},
}