event_inherited();

pre_update = function() {
	// win condition
	if (room != rm_podcast_machine) return;
	var complete = podcast_get_is_complete();
	if (complete) {
		audio_stop_sound(snd_music_tutorial);
		// feather ignore GM1043
		global.updateable = {
			alpha: 0.75,
			reel_alpha: 1,
			step: 0,
			steps: [
				function() {
					play_sfx(snd_win_achieved);
					step += 1;
				},
				function() {
					alpha -= (0.005 * (delta_time / global.frame_time));
					reel_alpha -= (0.01 * (delta_time / global.frame_time));
					if (alpha <= 0 && reel_alpha <= 0) {
						global.updateable = dialog_get_updateable([
							frank_get_dialog_step("Why...", FRANK_EXPRESSION.PODCAST_LEFT_UP),
							frank_get_dialog_step("I think we've got it!", FRANK_EXPRESSION.PODCAST_BLANK_PUMP),
							cory_get_dialog_step("Ooh!", CORY_EXPRESSION.PODCAST_WINGS),
							cory_get_dialog_step("Let's see it on the screen!", CORY_EXPRESSION.PODCAST_HIP),
						], {
							after_dialog_updateable: {
								update: complete_story,
							},
						});
					}
				},
			],
			update: function() {
				steps[step]();
			},
			draw: function() {
				var reels = [
					podcast_get_reel_at_position(global.podcast_tape_slots[0][0]),
					podcast_get_reel_at_position(global.podcast_tape_slots[0][1]),
					podcast_get_reel_at_position(global.podcast_tape_slots[0][2]),
					podcast_get_reel_at_position(global.podcast_tape_slots[1][0]),
					podcast_get_reel_at_position(global.podcast_tape_slots[1][1]),
					podcast_get_reel_at_position(global.podcast_tape_slots[1][2]),
					podcast_get_reel_at_position(global.podcast_tape_slots[2][0]),
					podcast_get_reel_at_position(global.podcast_tape_slots[2][1]),
					podcast_get_reel_at_position(global.podcast_tape_slots[2][2]),
					podcast_get_reel_at_position(global.podcast_tape_slots[3][0]),
					podcast_get_reel_at_position(global.podcast_tape_slots[3][1]),
					podcast_get_reel_at_position(global.podcast_tape_slots[3][2]),
				];
				shader_set(sh_green);
				shader_set_uniform_f(shader_get_uniform(sh_green, "alpha"), reel_alpha);
				for (var i = 0; i < array_length(reels); i++) {
					draw_sprite_ext(spr_tapereel, 0, reels[i].x, reels[i].y, 1, 1, reels[i].image_angle, c_white, 1);	
				}
				shader_reset();
				draw_set_alpha(alpha);
				draw_set_color(c_white);
				draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
			},
		};
	}
};

disabled = true;
draw = function() {}; // invisible
