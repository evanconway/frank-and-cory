function complete_story() {
	var chapter_art = {
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
		time: 0,
		step: 0,
		steps: [
			function() { // sync up with blackout
				if (time >= 100) {
					step += 1;
					time = 0;
				}
			},
			function() {
				chapter_spr_offsets[0].x += 2;
				if (chapter_spr_offsets[0].x >= 0) chapter_spr_offsets[0].x = 0;
				draw_chapter_art(0, 1, chapter_spr_offsets[0]);
			}
		],
		draw: function() {
			time += 1;
			steps[step]();
		},
	};
	
	var blackout = {
		black_alpha: 0,
		time: 0,
		step: 0,
		steps: [
			function() {
				black_alpha += 0.01;
				if (black_alpha >= 1) {
					play_sfx(snd_complete_story);
					step += 1;
					time = 0;
				}
			},
			function() {
				// if (black_alpha > 0) black_alpha -= 0.005;
			}
		],
		draw: function() {
			time += 1;
			steps[step]();
			draw_set_color(c_black);
			draw_set_alpha(black_alpha);
			draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
		},
	};
	
	/*
	It was a dark and stormy night.

	I was on my walk home when I spotted a bright red ball in the grass.

	But it wasn't a ball at all. It was a bird.

	He was missing a leg and he wasn't moving.

	It was raining so hard I had to hurry home.

	I brought the little red bird inside from the cold.

	He was shivering, so I covered him with a small blanket.

	He whistled while he slept.

	I noticed his wing was also broken. That gave me an idea.

	All night long, the little bird whistled and slept.

	I gathered what tools and supplies I could find. And I worked all night long (pause) creating what would soon become my best invention.

	By sunrise the bird awoke to discover his brand new wing (pause) and a new foot.

	He stood up and tried them out, flapping and whisteling happily.

	That is how I met my best friend Cory.
	*/
	
	/*
	He stood up and tried them out, flapping and whisteling happily.
	That is how I met my best friend Cory.
	*/
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
					// the pause syntax is broken, fix later.
					tag_decorated_text = get_new_text("I was on my walk home<p:1000> when I spotted a bright red ball in the grass.");
					step += 1;
				}
			},
			function() {
				if (time >= 282)	 {
					time = 0;
					tag_decorated_text = get_new_text("But it wasn't a ball at all. It was a bird.");
					step += 1;
				}
			},
			function() {
				if (time >= 227)	 {
					time = 0;
					tag_decorated_text = get_new_text("He was missing a leg and he wasn't moving.");
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
					tag_decorated_text = get_new_text("He was shivering, so I covered him with a small blanket.");
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
					tag_decorated_text = get_new_text("I noticed his wing was also broken. That gave me an idea.");
					step += 1;
				}
			},
			function() {
				if (time >= 388)	 {
					time = 0;
					tag_decorated_text = get_new_text("All night long, the little bird whistled and slept.");
					step += 1;
				}
			},
			function() {
				if (time >= 313)	 {
					time = 0;
					tag_decorated_text = get_new_text("I gathered what tools and supplies I could find. And I worked all night long (pause) creating what would soon become my best invention.");
					step += 1;
				}
			},
			function() {
				if (time >= 759)	 {
					time = 0;
					tag_decorated_text = get_new_text("By sunrise the bird awoke to discover his brand new wing (pause) and a new foot.");
					step += 1;
				}
			},
			function() {
				if (time >= 391)	 {
					time = 0;
					tag_decorated_text = get_new_text("He stood up and tried them out, flapping and whistling happily.");
					step += 1;
				}
			},
			function() {
				if (time >= 333)	 {
					time = 0;
					tag_decorated_text = get_new_text("That is how I met my best friend Cory.");
					step += 1;
				}
			},
			function() {
				if (time >= 300) {
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
			if (tag_decorated_text != undefined) tag_decorated_text_draw(tag_decorated_text, display_get_gui_width() / 2, display_get_gui_height() - 300);
		},
	};
	
	var podcast_animation_sequence = {
		draw: method({ chapter_art, blackout, text }, function() {
			//chapter_art.draw();
			blackout.draw();
			text.draw();
		}),
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
