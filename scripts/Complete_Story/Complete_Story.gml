/*
10.769 Cory Hurt in		646
16.800 Cory Hurt out	1008
24.558 Blanket in		1474
34.453 Blanket out		2067
43.535 Workbench in		2612
53.833 Workbench out	3230
57.562 Finish in		3454
72.004 Finish out		4320
*/

global.complete_story_sound_id = 0;

/**
 * Get frames elapsed for complete story audio. Returns 0 if audio is not playing.
 */
function complete_story_get_audio_time() {
	if (!audio_exists(global.complete_story_sound_id)) return 0;
	return audio_sound_get_track_position(global.complete_story_sound_id) * 60;
};

global.frank_podcast_hair_attached = false;

function complete_story() {
	
	// feather ignore GM1043
	global.podcast_attach_hair = {
		time: 0,
		step: 0,
		steps: [
			function() {
				global.frank_podcast_hair_attached = true;
				play_sfx(snd_jude_hair_attach);
				step += 1;
			},
			function() {
				if (time >= 150) {
					global.updateable = dialog_get_updateable([
						cory_get_dialog_step("Looking good! Let's go!", CORY_EXPRESSION.PODCAST_WINGS),
					], {
						after_dialog_updateable: {
							alpha: 0,
							alpha_change: 0.005,
							step: 0,
							steps: [
								function() {
									play_sfx(snd_music_finale, 0.8, 1, true);
									step += 1;
								},
								function() {
									alpha += (alpha_change * (delta_time / global.frame_time));
									if (alpha >= 1) {
										alpha = 1;
										step += 1 ;
									}
								},
								function() {
									room_goto(rm_outside);
									step += 1;
								},
								function() {
									if (room == rm_outside) {
										audio_sound_gain(play_sfx(snd_nature, 0, 1, true), 0.5, 3000);
										step += 1;
									}
								},
								function() {
									alpha -= (alpha_change * (delta_time / global.frame_time));
									if (alpha <= 0) {
										alpha = 0;
										global.updateable = global.credits;
									}
								},
							],
							update: function() {
								steps[step]();
							},
							draw: function() {
								if (room == rm_outside) {
									draw_set_alpha(1);
									draw_sprite(spr_water_ripples, 0, 0, 0);
									draw_sprite(spr_finale_frank, 0, 0, 0);
									draw_sprite(spr_finale_cory, 0, 0, 0);
								}
								draw_set_color(c_black);
								draw_set_alpha(alpha);
								draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
							},
						}
					});
				}
			},
		],
		update: function() {
			time += (delta_time / global.frame_time);
			steps[step]();
		},
	};
	
	global.podcast_dialog_end = dialog_get_updateable([
		cory_get_dialog_step("Oh my. That was beautiful, Frank.", CORY_EXPRESSION.PODCAST_WINGS),
		cory_get_dialog_step("Thank you.", CORY_EXPRESSION.PODCAST_NEUTRAL),
		frank_get_dialog_step("Thanks for helping me put it together!", FRANK_EXPRESSION.PODCAST_LEFT_UP),
		cory_get_dialog_step("So weird. I don't remember any of that.", CORY_EXPRESSION.PODCAST_HIP),
		frank_get_dialog_step("Well, you were pretty little back then.", FRANK_EXPRESSION.PODCAST_LEFT_DOWN),
		cory_get_dialog_step("Do you remember anything?", CORY_EXPRESSION.PODCAST_WINGS),
		cory_get_dialog_step("From when you were little?", CORY_EXPRESSION.PODCAST_NEUTRAL),
		frank_get_dialog_step("Hmm. Now that I think about it...", FRANK_EXPRESSION.PODCAST_UP_DOWN),
		frank_get_dialog_step("I don't know if I was ever \"little.\"", FRANK_EXPRESSION.PODCAST_LEFT_UP),
		cory_get_dialog_step("What do you say we go outside and record more stuff?", CORY_EXPRESSION.PODCAST_HIP),
		frank_get_dialog_step("Sounds fun!", FRANK_EXPRESSION.PODCAST_LEFT_PUMP),
		frank_get_dialog_step("But first.", FRANK_EXPRESSION.PODCAST_UP_UP),
		frank_get_dialog_step("Let me attach one more tape reel.", FRANK_EXPRESSION.PODCAST_BLANK_DOWN),
	], {
		after_dialog_updateable: global.podcast_attach_hair,
	});
	
	var chapter_art = {
		chapter_spr_offsets: [
			{ x: -200, y: 0},
			{ x: 0, y: -100},
			{ x: 200, y: 0},
			{ x: 0, y: 100},
			{ x: -200, y: 0},
		],
		draw_chapter_art: function(chapter=0, alpha=1) {
			draw_set_alpha(alpha);
			var scale = 1;
			draw_sprite_ext(
				spr_podcast_chapter_art,
				chapter,
				display_get_gui_width() / 2 + chapter_spr_offsets[chapter].x,
				display_get_gui_height() / 2 + chapter_spr_offsets[chapter].y,
				scale,
				scale,
				0,
				c_white,
				alpha
			);
		},
		crossfade_alpha: 1,
		pan_speed: 1,
		get_y_offset: function(index=0) {
			return sin(complete_story_get_audio_time() * 0.04 - index * 0.2 * pi) * 30;
		},
		notes_alpha: 0,
		step: 0,
		steps: [
			function() { // sync up with blackout
				if (complete_story_get_audio_time() >= 446) step += 1;
			},
			function() {
				chapter_spr_offsets[0].x += clamp(abs(chapter_spr_offsets[0].x) * 0.02, 0, pan_speed) * (delta_time / global.frame_time);
				chapter_spr_offsets[4].x += clamp(abs(chapter_spr_offsets[4].x) * 0.02, 0, pan_speed) * (delta_time / global.frame_time);
				if (chapter_spr_offsets[0].x >= 0) chapter_spr_offsets[0].x = 0;
				if (chapter_spr_offsets[4].x >= 0) chapter_spr_offsets[4].x = 0;
				if (complete_story_get_audio_time() >= 646) {
					crossfade_alpha = clamp(crossfade_alpha - (0.01 * (delta_time / global.frame_time)), 0, 1);
				}
				draw_chapter_art(4, crossfade_alpha);
				draw_chapter_art(0, abs(-1 + crossfade_alpha));
				if (complete_story_get_audio_time() >= 1474) step += 1;
			},
			function() {
				chapter_spr_offsets[1].y += clamp(abs(chapter_spr_offsets[1].y) * 0.03, 0, pan_speed) * (delta_time / global.frame_time);
				if (chapter_spr_offsets[1].y >= 0) chapter_spr_offsets[1].y = 0;
				draw_chapter_art(1);
				if (complete_story_get_audio_time() >= 1800) {
					notes_alpha = clamp(notes_alpha + (0.01 * (delta_time / global.frame_time)), 0, 1);
					draw_sprite_ext(spr_podcast_musicnotes, 0, 0, chapter_spr_offsets[1].y + get_y_offset(0), 1, 1, 0, c_white, notes_alpha);
					draw_sprite_ext(spr_podcast_musicnotes, 1, 0, chapter_spr_offsets[1].y + get_y_offset(1), 1, 1, 0, c_white, notes_alpha);
					draw_sprite_ext(spr_podcast_musicnotes, 2, 0, chapter_spr_offsets[1].y + get_y_offset(2), 1, 1, 0, c_white, notes_alpha);
					draw_sprite_ext(spr_podcast_musicnotes, 3, 0, chapter_spr_offsets[1].y + get_y_offset(3), 1, 1, 0, c_white, notes_alpha);
					draw_sprite_ext(spr_podcast_musicnotes, 4, 0, chapter_spr_offsets[1].y + get_y_offset(4), 1, 1, 0, c_white, notes_alpha);
					draw_sprite_ext(spr_podcast_musicnotes, 5, 0, chapter_spr_offsets[1].y + get_y_offset(5), 1, 1, 0, c_white, notes_alpha);
				}
				if (complete_story_get_audio_time() >= 2612) step += 1;
			},
			function() {
				chapter_spr_offsets[2].x -= clamp(abs(chapter_spr_offsets[2].x) * 0.05, 0, pan_speed)  * (delta_time / global.frame_time);
				if (chapter_spr_offsets[2].x <= 0) chapter_spr_offsets[2].x = 0;
				draw_chapter_art(2);
				if (complete_story_get_audio_time() >= 3454) step += 1;
			},
			function() {
				chapter_spr_offsets[3].y -= clamp(abs(chapter_spr_offsets[3].y) * 0.03, 0, pan_speed) * (delta_time / global.frame_time);
				if (chapter_spr_offsets[3].y <= 0) chapter_spr_offsets[3].y = 0;
				if (audio_is_playing(global.complete_story_sound_id) && complete_story_get_audio_time() <= 4600) draw_chapter_art(3);
			},
		],
		draw: function() {
			draw_set_alpha(1);
			steps[step]();
		},
	};
	var vignette = {
		get_alpha: function(rads=0) {
			return (sin(rads) + 1) / 2;
		},
		draw: function() {
			if (complete_story_get_audio_time() >= 446 && complete_story_get_audio_time() <= 4600) {
				var rads = complete_story_get_audio_time() * 0.015;
				var offset = 2 * pi / 3;
				draw_sprite_ext(spr_vignette, 0, 0, 0, 1, 1, 0, c_white, get_alpha(rads));
				draw_sprite_ext(spr_vignette, 1, 0, 0, 1, 1, 0, c_white, get_alpha(rads + offset));
				draw_sprite_ext(spr_vignette, 2, 0, 0, 1, 1, 0, c_white, get_alpha(rads + offset + offset));
			}
		},
	};
	var blackout = {
		black_alpha: 1,
		step: 0,
		set_reel_position: function(reel_object, position_object) {
			reel_object.x = position_object.x;
			reel_object.y = position_object.y;
		},
		steps: [
			function() {
				global.complete_story_sound_id = play_sfx(snd_complete_story);
				step += 1;
			},
			function() {
				if (complete_story_get_audio_time() >= 446) step += 1;
			},
			function() {
				black_alpha = clamp(black_alpha - (0.005 * (delta_time / global.frame_time)), 0, 1);
				if (complete_story_get_audio_time() >= 1008) step += 1;
			},
			function() {
				black_alpha = clamp(black_alpha + (0.01 * (delta_time / global.frame_time)), 0, 1);
				if (complete_story_get_audio_time() >= 1474) step += 1;
			},
			function() {
				black_alpha = clamp(black_alpha - (0.005 * (delta_time / global.frame_time)), 0, 1);
				if (complete_story_get_audio_time() >= 2067) step += 1;
			},
			function() {
				black_alpha = clamp(black_alpha + (0.01 * (delta_time / global.frame_time)), 0, 1);
				if (complete_story_get_audio_time() >= 2612) step += 1;
			},
			function() {
				black_alpha = clamp(black_alpha - (0.005 * (delta_time / global.frame_time)), 0, 1);
				if (complete_story_get_audio_time() >= 3230) step += 1;
			},
			function() {
				black_alpha = clamp(black_alpha + (0.01 * (delta_time / global.frame_time)), 0, 1);
				if (complete_story_get_audio_time() >= 3454) step += 1;
			},
			function() {
				black_alpha = clamp(black_alpha - (0.005 * (delta_time / global.frame_time)), 0, 1);
				if (complete_story_get_audio_time() >= 4320) step += 1;
			},
			function() {
				black_alpha = clamp(black_alpha + (0.01 * (delta_time / global.frame_time)), 0, 1);
				if (!audio_is_playing(snd_complete_story)) {
					step += 1;
					room_goto(rm_podcast_machine);
				}
			},
			function() {
				if (room == rm_podcast_machine) {
					set_reel_position(inst_7AAB43BD, inst_316D019);
					set_reel_position(inst_25994B2C, inst_539A57D8);
					set_reel_position(inst_1772A928, inst_5E6A593);
					set_reel_position(inst_5AA3BDBA, inst_BEF507);
					set_reel_position(inst_2D775EEB, inst_3A9D56AE);
					set_reel_position(inst_2B424FAD, inst_51AF4FDE);
					set_reel_position(inst_20707053, inst_2D0E8C1F);
					set_reel_position(inst_586C1312, inst_22FEC13C);
					set_reel_position(inst_DBB61CD, inst_3183B74B);
					set_reel_position(inst_C74BBA9, inst_4D144C3);
					set_reel_position(inst_344345C4, inst_1202BE7A);
					set_reel_position(inst_49F5CA89, inst_4633AB96);
					step += 1;
				}
			},
			function() {
				black_alpha = clamp(black_alpha - (0.01 * (delta_time / global.frame_time)), 0, 1);
				if (black_alpha <= 0) {
					global.updateable = global.podcast_dialog_end;
				}
			},
		],
		draw: function() {
			steps[step]();
			draw_set_color(c_black);
			draw_set_alpha(black_alpha);
			draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
		},
	};
	var text = {
		get_new_text: function(text="") {
			var result = new TagDecoratedTextDefault(text, "f:fnt_ally t:40,1 fadein", 3000, 1000);
			tag_decorated_text_reset_typing(result);
			return result;
		},
		tag_decorated_text: undefined,
		step: 0,
		steps: [
			function() {
				if (complete_story_get_audio_time() >= 90) {
					tag_decorated_text = get_new_text("It was a dark and stormy night.");
					step += 1;
				}
			},
			function() {
				if (complete_story_get_audio_time() >= 220) {
					tag_decorated_text = get_new_text("I was on my walk hom<p:1000>e when I spotted a bright red ball in the grass.");
					step += 1;
				}
			},
			function() {
				if (complete_story_get_audio_time() >= 502) {
					tag_decorated_text = get_new_text("But it wasn't a ball at all<p:1100>. It was a bird.");
					step += 1;
				}
			},
			function() {
				if (complete_story_get_audio_time() >= 729) {
					tag_decorated_text = get_new_text("He was missing a leg<p:1200>, and he wasn't moving.");
					step += 1;
				}
			},
			function() {
				if (complete_story_get_audio_time() >= 1000) {
					tag_decorated_text = get_new_text("It was raining so hard I had to hurry home.");
					step += 1;
				}
			},
			function() {
				if (complete_story_get_audio_time() >= 1169) {
					tag_decorated_text = get_new_text("I brought the little red bird inside from the cold.");
					step += 1;
				}
			},
			function() {
				if (complete_story_get_audio_time() >= 1389) {
					tag_decorated_text = get_new_text("He was shivering<p:1200>, so I covered him with a small blanket.");
					step += 1;
				}
			},
			function() {
				if (complete_story_get_audio_time() >= 1726) {
					tag_decorated_text = get_new_text("He whistled while he slept.");
					step += 1;
				}
			},
			function() {
				if (complete_story_get_audio_time() >= 1888) {
					tag_decorated_text = get_new_text("I noticed his wing was also broken<p:1700>. That gave me an idea.");
					step += 1;
				}
			},
			function() {
				if (complete_story_get_audio_time() >= 2276) {
					tag_decorated_text = get_new_text("All night lon<p:750>g the little bird whistle<p:800>d and slept.");
					step += 1;
				}
			},
			function() {
				if (complete_story_get_audio_time() >= 2589) {
					tag_decorated_text = get_new_text("I gathered what tools and supplies I could find<p:1800>. And I worked all night lon<p:1500>g creating what would soon becom<p:1100>e my best invention.");
					step += 1;
				}
			},
			function() {
				if (complete_story_get_audio_time() >= 3348) {
					tag_decorated_text = get_new_text("By sunrise<p:500>, the bird awoke to discover his brand new win<p:2000>g and a new foot.");
					step += 1;
				}
			},
			function() {
				if (complete_story_get_audio_time() >= 3739) {
					tag_decorated_text = get_new_text("He stood up and tried them out<p:1300>, flapping and whistling happily.");
					step += 1;
				}
			},
			function() {
				if (complete_story_get_audio_time() >= 4072) {
					tag_decorated_text = get_new_text("That is how I me<p:500>t my best friend, Cory.");
					step += 1;
				}
			},
			function() {
				if (complete_story_get_audio_time() >= 4472) {
					tag_decorated_text = undefined;
					step += 1;
				}
			},
			function() {},
		],
		draw: function() {
			steps[step]();
			draw_set_halign(fa_center);
			draw_set_valign(fa_bottom);
			draw_set_alpha(1);
			if (tag_decorated_text != undefined) {
				tag_decorated_text_update(tag_decorated_text, delta_time / 1000);
				tag_decorated_text_draw_no_update(tag_decorated_text, display_get_gui_width() / 2, display_get_gui_height() - 100);
			}
		},
	};
	
	var podcast_animation_sequence = {
		draw: method({ chapter_art, vignette, blackout, text }, function() {
			chapter_art.draw();
			vignette.draw();
			blackout.draw();
			text.draw();
		}),
		update: function() {},
	};

	var fade_to_black = {
		alpha: 0,
		step: 0,
		time: 0,
		image_time: 0,
		image: 0,
		podcast_animation_sequence,
		steps: [
			function() {
				audio_sound_gain(play_sfx(snd_tv_static, 0.7, 1, false), 0, 2500);
				step += 1;
			},
			function() {
				alpha += (0.007 * (delta_time / global.frame_time));
				if (alpha >= 1) {
					step += 1;
					time = 0;
				}
			},
			function() {
				room_goto(rm_with_nothing);
				step += 1;
			},
			function() {
				if (room == rm_with_nothing) {
					step += 1;
					time = 0;
				}
			},
			function() {
				if (time >= 70) {
					global.updateable = podcast_animation_sequence;
				}
			},
		],
		update: function() {
			time += (delta_time / global.frame_time);
			image_time += 1;
			if (image_time >= 11) {
				image_time = 0;
				image += 1;
				if (image >= 3) image = 0;
			}
			steps[step]();
		},
		draw: function() {
			draw_set_alpha(1);
			draw_sprite(spr_tv_static, image, 0, 0);
			draw_set_color(c_black);
			draw_set_alpha(alpha);
			draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
		},
	};
	
	global.updateable = fade_to_black;
}
