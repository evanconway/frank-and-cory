function complete_story() {
	var podcast_animation_sequence = {
		chapter_spr_offsets: [
			{ x: -1000, y: 0},
			{ x: -1000, y: -1000},
			{ x: 1000, y: 0},
			{ x: 0, y: 1000},
		],
		draw_chapter_art: function(chapter=0, alpha=1, offsets={ x: 0, y: 0}) {
			draw_set_alpha(alpha);
			var scale = 1.4;
			draw_sprite_ext(
				spr_podcast_chapter_art,
				chapter,
				display_get_gui_width() / 2 + offsets.x,
				display_get_gui_height() / 2 + offsets.y,
				scale,
				scale,
				0,
				c_white,
				alpha
			);
		},
		black_alpha: 0,
		time: 0,
		step: 0,
		steps: [
			function() {
				black_alpha += 0.01;
				if (black_alpha >= 1) {
					step += 1;
					play_sfx(snd_complete_story);
				}
			},
			function() {
				if (black_alpha > 0) black_alpha -= 0.005;
				chapter_spr_offsets[0].x += 2;
				if (chapter_spr_offsets[0].x >= 0) chapter_spr_offsets[0].x = 0;
				draw_chapter_art(0, 1, chapter_spr_offsets[0]);
				
			}
		],
		draw: function() {
			draw_set_alpha(1);
			steps[step]();
			draw_set_color(c_black);
			draw_set_alpha(black_alpha);
			draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
		},
		update: function() {},
	};
	
	global.updateable = podcast_animation_sequence;
	
	/*
	global.updateable = dialog_get_updateable([
		frank_get_dialog_step("Why...", FRANK_EXPRESSION.PODCAST_LEFT_UP),
		frank_get_dialog_step("I think we've got it!", FRANK_EXPRESSION.PODCAST_BLANK_PUMP),
		cory_get_dialog_step("Ooh!", CORY_EXPRESSION.PODCAST_WINGS),
		cory_get_dialog_step("Let's see it on the screen!", CORY_EXPRESSION.PODCAST_HIP),
	], {
		after_dialog_updateable: podcast_animation_sequence,
	});
	*/
}
