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

function complete_story() {
	global.podcast_dialog_end = dialog_get_updateable([
		cory_get_dialog_step("Oh my. That was beautiful, Frank.", CORY_EXPRESSION.PODCAST_WINGS),
		cory_get_dialog_step("Thank you.", CORY_EXPRESSION.PODCAST_NEUTRAL),
		frank_get_dialog_step("Thanks for helping me put it together!", FRANK_EXPRESSION.PODCAST_LEFT_UP),
		cory_get_dialog_step("So weird, I don't remember any of that.", CORY_EXPRESSION.PODCAST_HIP),
		frank_get_dialog_step("Well, you were pretty little back then.", FRANK_EXPRESSION.PODCAST_LEFT_DOWN),
		cory_get_dialog_step("Do you remember anything?", CORY_EXPRESSION.PODCAST_WINGS),
		cory_get_dialog_step("From when you were little?", CORY_EXPRESSION.PODCAST_NEUTRAL),
		frank_get_dialog_step("Hmm. Now that I think about it...", FRANK_EXPRESSION.PODCAST_UP_DOWN),
		frank_get_dialog_step("I don't know if I was little.", FRANK_EXPRESSION.PODCAST_LEFT_UP),
		cory_get_dialog_step("What do you say we go outside and record more stuff?", CORY_EXPRESSION.PODCAST_HIP),
		frank_get_dialog_step("Sounds fun!", FRANK_EXPRESSION.PODCAST_LEFT_PUMP),
		frank_get_dialog_step("Let me attach new tape reels!", FRANK_EXPRESSION.PODCAST_BLANK_DOWN),
		cory_get_dialog_step("Looking good! Let's go!", CORY_EXPRESSION.PODCAST_WINGS),
	], {
		after_dialog_updateable: {
			alpha: 0,
			step: 0,
			steps: [
				function() {
					alpha += 0.01;
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
						play_sfx(snd_music_peace);
						audio_sound_gain(play_sfx(snd_nature, 0, 1, true), 0.7, 3000);
						step += 1;
					}
				},
				function() {
					alpha -= 0.01;
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
				draw_set_color(c_black);
				draw_set_alpha(alpha);
				draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
			},
		}
	});
	
	var chapter_art = {
		chapter_spr_offsets: [
			{ x: -200, y: 0},
			{ x: 0, y: -100},
			{ x: 200, y: 0},
			{ x: 0, y: 100},
		],
		draw_chapter_art: function(chapter=0, alpha=1) {
			draw_set_alpha(alpha);
			var scale = 1.1;
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
		pan_speed: 1,
		time: 0,
		step: 0,
		steps: [
			function() { // sync up with blackout
				if (time >= 646) step += 1;
			},
			function() {
				chapter_spr_offsets[0].x += clamp(abs(chapter_spr_offsets[0].x) * 0.05, 0, pan_speed);
				draw_chapter_art(0);
				if (time >= 1474) step += 1;
			},
			function() {
				chapter_spr_offsets[1].y += clamp(abs(chapter_spr_offsets[1].y) * 0.03, 0, pan_speed);
				draw_chapter_art(1);
				if (time >= 2612) step += 1;
			},
			function() {
				chapter_spr_offsets[2].x -= clamp(abs(chapter_spr_offsets[2].x) * 0.05, 0, pan_speed);
				draw_chapter_art(2);
				if (time >= 3654) step += 1;
			},
			function() {
				chapter_spr_offsets[3].y -= clamp(abs(chapter_spr_offsets[3].y) * 0.03, 0, pan_speed);
				if (time <= 4600) draw_chapter_art(3);
			},
		],
		draw: function() {
			time += 1;
			draw_set_alpha(1);
			steps[step]();
		},
	};
	var blackout = {
		black_alpha: 0,
		time: 0, // don't reset time between steps
		step: 0,
		steps: [
			function() {
				black_alpha = clamp(black_alpha + 0.01, 0, 1);
				if (black_alpha >= 1) {
					play_sfx(snd_complete_story);
					step += 1;
				}
			},
			function() {
				if (time >= 646) step += 1;
			},
			function() {
				black_alpha = clamp(black_alpha - 0.005, 0, 1);
				if (time >= 1008) step += 1;
			},
			function() {
				black_alpha = clamp(black_alpha + 0.01, 0, 1);
				if (time >= 1474) step += 1;
			},
			function() {
				black_alpha = clamp(black_alpha - 0.005, 0, 1);
				if (time >= 2067) step += 1;
			},
			function() {
				black_alpha = clamp(black_alpha + 0.01, 0, 1);
				if (time >= 2612) step += 1;
			},
			function() {
				black_alpha = clamp(black_alpha - 0.005, 0, 1);
				if (time >= 3230) step += 1;
			},
			function() {
				black_alpha = clamp(black_alpha + 0.01, 0, 1);
				if (time >= 3654) step += 1;
			},
			function() {
				black_alpha = clamp(black_alpha - 0.005, 0, 1);
				if (time >= 4320) step += 1;
			},
			function() {
				black_alpha = clamp(black_alpha + 0.01, 0, 1);
				if (time >= 4600) step += 1;
			},
			function() {
				black_alpha = clamp(black_alpha - 0.01, 0, 1);
				if (black_alpha <= 0) {
					global.updateable = global.podcast_dialog_end;
				}
			},
		],
		draw: function() {
			time += 1;
			steps[step]();
			draw_set_color(c_black);
			draw_set_alpha(black_alpha);
			draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
		},
	};
	
	var text = {
		get_new_text: function(text="") {
			if (string_starts_with(text, "I was on my walk home")) {
				show_debug_message("debug");
			}
			var result = new TagDecoratedTextDefault(text, "f:fnt_ally t:40,1 fadein", 2000, 1000);
			tag_decorated_text_reset_typing(result);
			return result;
		},
		tag_decorated_text: undefined,
		time: 0,
		step: 0,
		steps: [
			function() {
				if (time >= 190)	 {
					time = 0;
					tag_decorated_text = get_new_text("It was a dark and stormy night.");
					step += 1;
				}
			},
			function() {
				if (time >= 130)	 {
					time = 0;
					tag_decorated_text = get_new_text("I was on my walk hom<p:1000>e when I spotted a bright red ball in the grass.");
					step += 1;
				}
			},
			function() {
				if (time >= 282)	 {
					time = 0;
					tag_decorated_text = get_new_text("But it wasn't a ball at all<p:1100>. It was a bird.");
					step += 1;
				}
			},
			function() {
				if (time >= 227)	 {
					time = 0;
					tag_decorated_text = get_new_text("He was missing a le<p:1200>g and he wasn't moving.");
					step += 1;
				}
			},
			function() {
				if (time >= 271)	 {
					time = 0;
					tag_decorated_text = get_new_text("It was raining so hard I had to hurry home.");
					step += 1;
				}
			},
			function() {
				if (time >= 169)	 {
					time = 0;
					tag_decorated_text = get_new_text("I brought the little red bird inside from the cold.");
					step += 1;
				}
			},
			function() {
				if (time >= 220)	 {
					time = 0;
					tag_decorated_text = get_new_text("He was shiverin<p:1200>g so I covered him with a small blanket.");
					step += 1;
				}
			},
			function() {
				if (time >= 337)	 {
					time = 0;
					tag_decorated_text = get_new_text("He whistled while he slept.");
					step += 1;
				}
			},
			function() {
				if (time >= 162)	 {
					time = 0;
					tag_decorated_text = get_new_text("I noticed his wing was also broken<p:1700>. That gave me an idea.");
					step += 1;
				}
			},
			function() {
				if (time >= 388)	 {
					time = 0;
					tag_decorated_text = get_new_text("All night lon<p:750>g the little bird whistled and slept.");
					step += 1;
				}
			},
			function() {
				if (time >= 313)	 {
					time = 0;
					tag_decorated_text = get_new_text("I gathered what tools and supplies I could find<p:1800>. And I worked all night lon<p:1500>g creating what would soon becom<p:1100>e my best invention.");
					step += 1;
				}
			},
			function() {
				if (time >= 759)	 {
					time = 0;
					tag_decorated_text = get_new_text("By sunris<p:500>e the bird awoke to discover his brand new win<p:2000>g and a new foot.");
					step += 1;
				}
			},
			function() {
				if (time >= 391)	 {
					time = 0;
					tag_decorated_text = get_new_text("He stood up and tried them out<p:1300>, flapping and whistling happily.");
					step += 1;
				}
			},
			function() {
				if (time >= 333)	 {
					time = 0;
					tag_decorated_text = get_new_text("That is how I me<p:500>t my best friend Cory.");
					step += 1;
				}
			},
			function() {
				if (time >= 400) {
					tag_decorated_text = undefined;
					time = 0;
					step += 1;
				}
			},
			function() {},
		],
		draw: function() {
			time += 1;
			steps[step]();
			draw_set_halign(fa_center);
			draw_set_valign(fa_bottom);
			draw_set_alpha(1);
			if (tag_decorated_text != undefined) tag_decorated_text_draw(tag_decorated_text, display_get_gui_width() / 2, display_get_gui_height() - 300);
		},
	};
	
	var podcast_animation_sequence = {
		draw: method({ chapter_art, blackout, text }, function() {
			chapter_art.draw();
			blackout.draw();
			text.draw();
		}),
		update: function() {},
	};
	
	global.updateable = podcast_animation_sequence;
}
