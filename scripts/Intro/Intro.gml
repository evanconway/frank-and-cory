global.intro_blackout_alpha = 1;
global.breaker_open = false;
global.light_switch_on = false;

global.intro_blackout_func = function() {
	draw_set_alpha(global.intro_blackout_alpha);
	draw_set_color(c_black);
	draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
};

function start_intro() {	
	var cory_flys_back_to_perch = {
		// flight position is line function
		flight: {
			position_start: { x: 1935,y: 1096 },
			position_end: { x: 4800, y: -120 },
			get_slope: function() {
				return (position_end.y - position_start.y) / (position_end.x - position_start.x);
			},
			progress: 0,
			get_x: function() {
				var diff = (position_start.x - position_end.x) * progress * -1;
				return floor(position_start.x + diff);
			},
			get_y: function() {
				return floor(position_start.y + get_slope() * (get_x() - position_start.x));
			},
			get_subimage: function() {
				if (progress > 0.6) return 0;
				return floor(progress * 7);
			},
		},
		update: function() {
			obj_workshop_cory.visible = false;
			flight.progress += (0.015 * (delta_time / global.frame_time));
			if (flight.progress >= 1) {
				obj_workshop_cory.x = 0;
				obj_workshop_cory.y = 0;
				global.cory_dialog_position = CORY_DIALOG_POSITION.INTRO_BREAKER;
				global.updateable = dialog_get_updateable([
					cory_get_dialog_step("Maybe if I can find the piece that fits in that slot,", CORY_EXPRESSION.BOTH_WINGS),
					cory_get_dialog_step("we'll get you back to your normal self.", CORY_EXPRESSION.TILT),
				]);
			}
		},
		draw: function() {
			var sub_image = flight.get_subimage();
			var fly_x = flight.get_x();
			var fly_y = flight.get_y();
			draw_sprite_ext(spr_cory_flying, sub_image, fly_x, fly_y, -1, 1, 0, c_white, 1);
			//draw_sprite(spr_cory_flying, sub_image, fly_x, fly_y);
		},
	};
	
	var cory_knows_somethings_up = dialog_get_updateable([
		cory_get_dialog_step("Okay. Something's not right.", CORY_EXPRESSION.NEUTRAL),
		frank_get_dialog_step("Hey. What are you doing up there? Get away from me!", FRANK_EXPRESSION.UP),
		cory_get_dialog_step("Oh. I see it now.", CORY_EXPRESSION.TAP),
		frank_get_dialog_step("What is it? What do you see?", FRANK_EXPRESSION.BLANK),
		cory_get_dialog_step("There's a little rectangle back here that says \"memory.\"", CORY_EXPRESSION.BOTH_WINGS),
		frank_get_dialog_step("What's a memory?", FRANK_EXPRESSION.UP),
		cory_get_dialog_step("Hah. Good one.", CORY_EXPRESSION.SALUTE),
		frank_get_dialog_step("Good what?", FRANK_EXPRESSION.RIGHT),
		cory_get_dialog_step("Oh. You're being serious. Never mind.", CORY_EXPRESSION.TILT),
	],{
		after_dialog_updateable: cory_flys_back_to_perch
	});
	
	var cory_taps_head = {
		cory_knows_somethings_up,
		time: 0,
		step: 0,
		steps: [
			function() {
				global.cory_expression = CORY_EXPRESSION.NEUTRAL;
				if (time > 45) {
					time = 0;
					step++;
					global.cory_expression = CORY_EXPRESSION.TAP;
					play_sfx(snd_type);
				}
			},
			function() {
				global.cory_expression = CORY_EXPRESSION.TAP;
				if (time > 10) {
					time = 0;
					step++;
				}
			},
			function() {
				global.cory_expression = CORY_EXPRESSION.NEUTRAL;
				if (time > 10) {
					time = 0;
					step++;
					global.cory_expression = CORY_EXPRESSION.TAP;
					play_sfx(snd_type);
				}
			},
			function() {
				global.cory_expression = CORY_EXPRESSION.TAP;
				if (time > 10) {
					time = 0;
					step++;
				}
			},
			function() {
				global.cory_expression = CORY_EXPRESSION.NEUTRAL;
				if (time > 60) {
					global.cory_dialog_position = CORY_DIALOG_POSITION.INTRO_HEAD;
					global.updateable = cory_knows_somethings_up;
				}
			},
		],
		update: function() {
			time += (delta_time / global.frame_time);
			steps[step]();
		},
	};
	
	var cory_flys_to_head = {
		cory_taps_head,
		// flight position is line function
		flight: {
			position_start: { x: 3912, y: -191 },
			position_end: { x: 1033,y: 991 },
			get_slope: function() {
				return (position_end.y - position_start.y) / (position_end.x - position_start.x);
			},
			progress: 0,
			get_x: function() {
				var diff = (position_start.x - position_end.x) * progress * -1;
				return floor(position_start.x + diff);
			},
			get_y: function() {
				return floor(position_start.y + get_slope() * (get_x() - position_start.x));
			},
			get_subimage: function() {
				if (progress > 0.6) return 0;
				return floor(progress * 7);
			},
		},
		update: function() {
			obj_workshop_cory.visible = false;
			flight.progress += (0.015 * (delta_time / global.frame_time));
			if (flight.progress >= 1) {
				obj_workshop_cory.x = -3206;
				obj_workshop_cory.y = 1280;
				global.updateable = cory_taps_head;
			}
		},
		draw: function() {
			var sub_image = flight.get_subimage();
			var fly_x = flight.get_x();
			var fly_y = flight.get_y();
			draw_sprite(spr_cory_flying, sub_image, fly_x, fly_y);
		},
	};
	
	var oh_no_my_body_dialog = dialog_get_updateable([
		frank_get_dialog_step("Ah! My body! What happened to me?", FRANK_EXPRESSION.BLANK),
		cory_get_dialog_step("This place could use some spring cleaning, don't you think?", CORY_EXPRESSION.BOTH_WINGS),
		frank_get_dialog_step("Am I dying? Am I dead? Is this death?", FRANK_EXPRESSION.UP),
		cory_get_dialog_step("You're going to be okay. Just in a little shock is all.", CORY_EXPRESSION.NEUTRAL),
		cory_get_dialog_step("Heh. Get it?", CORY_EXPRESSION.SALUTE),
		frank_get_dialog_step("I don't.", FRANK_EXPRESSION.UNAMUSED),
		cory_get_dialog_step("Do you remember anything before the outage?", CORY_EXPRESSION.TILT),
		frank_get_dialog_step("I don't even know who you are.", FRANK_EXPRESSION.RIGHT),
		cory_get_dialog_step("Huh?", CORY_EXPRESSION.BOTH_WINGS),
	], { after_dialog_updateable: cory_flys_to_head });

	var brief_pause = {
		oh_no_my_body_dialog,
		flicker_time: 5,
		alpha: 0,
		time: 0,
		step: 0,
		steps: [
			function () {
				alpha = 0;
				if (time >= flicker_time) {
					step++;
					time = 0;
				}
			},
			function () {
				alpha = 0.5;
				if (time >= flicker_time) {
					step++;
					time = 0;
				}
			},
			function () {
				alpha = 0;
				if (time >= flicker_time) {
					step++;
					time = 0;
				}
			},
			function () {
				alpha = 0.5;
				if (time >= flicker_time) {
					step++;
					time = 0;
				}
			},
			function () {
				alpha = 0;
				if (time >= 100) {
					time = 0;
					step += 1;
					play_sfx(snd_music_workshop, 0.8, 1, true);
				}
			},
			function () {
				if (time >= 60) {
					global.updateable = oh_no_my_body_dialog;
				}
			}
		],
		update: function() {
			time += (delta_time / global.frame_time);
			steps[step]();
		},
		draw: function() {
			draw_set_color(c_black);
			draw_set_alpha(alpha);
			draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
		}
	}

	// this feels hacky, review later
	global.find_breaker_mini_game = {
		brief_pause,
		update: function() {
			global.frank_expression = FRANK_EXPRESSION.NEUTRAL;
			global.cory_expression = CORY_EXPRESSION.NEUTRAL;
			if (global.flashlight_on == false) {
				global.flashlight_on = true;
				play_sfx(snd_button, 1, 0.9);
			}
			var breaker_clicked = false;
			with (obj_breaker) {
				if (position_meeting(mouse_x, mouse_y, id)) global.clickable_hovered = id;
				if (mouse_check_button_pressed(mb_any) && global.clickable_hovered == id) {
					breaker_clicked = true;
					if (!global.breaker_open) {
						global.breaker_open = true;
						play_sfx(snd_button, 1, 0.6);
						return;
					}
					audio_stop_sound(snd_music_intro);
					global.light_switch_on = true;
					play_sfx(snd_jude_breaker_switch);
					play_sfx(snd_jude_light_flicker);
					global.updateable = other.brief_pause;
					var lay_id = layer_get_id("Background");
					var back_id = layer_background_get_id(lay_id);
					layer_background_sprite(back_id, spr_workshop);
				};
			}
			if (!breaker_clicked) with (obj_clickable) {
				if (position_meeting(mouse_x, mouse_y, id) && mouse_check_button_pressed(mb_any)) {
					global.updateable = dialog_get_updateable([cory_get_dialog_step("I don't think that's right.", CORY_EXPRESSION.NEUTRAL)], {
						after_dialog_updateable: global.find_breaker_mini_game,
						pre_dialog_draw: darkness,
					});
				}
			}
		},
		draw: function() {
			with (obj_breaker) {
				pre_draw();
				draw();
				if (global.clickable_hovered == id) {
					shader_set(sh_hovered);
					draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, 1);
					shader_reset();
				}
			}
			darkness();
		},
	};

	var find_breaker_dialog = dialog_get_updateable([
		frank_get_dialog_step("Who is... Frank?", FRANK_EXPRESSION.BLANK),
		cory_get_dialog_step("Geez, that power outage must have really knocked you out.", CORY_EXPRESSION.TILT),
		frank_get_dialog_step("Why can't I feel my arms?", FRANK_EXPRESSION.UP),
		cory_get_dialog_step("One sec, I'm looking for the breaker box.", CORY_EXPRESSION.NEUTRAL),
	], { after_dialog_updateable: global.find_breaker_mini_game, pre_dialog_draw: darkness });

	var cory_light_fade = {
		find_breaker_dialog,
		update: function() {
			global.frank_expression = FRANK_EXPRESSION.RIGHT
			global.cory_light_alpha += (0.01 * (delta_time / global.frame_time));
			if (global.cory_light_alpha >= 1) {
				global.updateable = find_breaker_dialog;
			}
		},
		draw: darkness,
	};

	var cory_responds = dialog_get_updateable([
		frank_get_dialog_step("Oh. I must have fallen asleep.", FRANK_EXPRESSION.UNAMUSED),
		cory_get_dialog_step("Frank!"),
		frank_get_dialog_step("Huh?", FRANK_EXPRESSION.RIGHT),
		cory_get_dialog_step("Are you alright?"),
		frank_get_dialog_step("Where's that voice coming from?", FRANK_EXPRESSION.UP),
		cory_get_dialog_step("Frank! Over here!")
	], { after_dialog_updateable: cory_light_fade, pre_dialog_draw: darkness });

	var fade_in_scene = {
		cory_responds,
		update: function() {
			global.intro_blackout_alpha -= (0.01 * (delta_time / global.frame_time));
			if (global.intro_blackout_alpha > 0) return;
			global.intro_blackout_alpha = 0;
			global.updateable = cory_responds;
		},
		draw: function() {
			darkness();
			global.intro_blackout_func();
		},
	};

	var opening_lines = dialog_get_updateable([
		{
			text: "...",
			on_type: global.frank_speaks,
			default_effects: "f:fnt_ally t:300,1",
		},
		{
			text: "Huh?",
			on_type: global.frank_speaks,
			default_effects: "f:fnt_ally t:300,1",
		},
		{
			text: "Oh...",
			on_type: global.frank_speaks,
			default_effects: "f:fnt_ally t:300,1",
		},
		{
			text: "Where am I?",
			on_type: global.frank_speaks,
			default_effects: "f:fnt_ally t:300,2",
		}
	], {
		after_dialog_updateable: fade_in_scene,
		pre_dialog_draw: function() {
			draw_set_alpha(1);
			draw_set_color(c_black);
			draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			global.dialog_position_x = display_get_gui_width() / 2;
			global.dialog_position_y = display_get_gui_height() / 2;
		}
	});

	var small_pause = {
		opening_lines,
		time: 0,
		update: function() {
			time += (delta_time / global.frame_time);
			if (time > 60) global.updateable = opening_lines;
		},
		draw: function() {
			draw_set_alpha(1);
			draw_set_color(c_black);
			draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
		},
	};
	
	// solves a bug where html audio doesn't play immediately
	var music_pause = {
		small_pause,
		time: 0,
		update: function() {
			time += (delta_time / global.frame_time);
			if (time >= 2) {
				play_sfx(snd_music_intro, 0.5, 1, true);
				global.updateable = small_pause;
			}
		},
		draw: function() {
			draw_set_alpha(1);
			draw_set_color(c_black);
			draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
		},
	};

	var init = {
		music_pause,
		tds: new TagDecoratedTextDefault("click to start", "f:fnt_ally fade"),
		update: function() {
			if (room != rm_workshop) return;
			if (mouse_check_button_pressed(mb_any)) {
				prepare_darkness();
				var lay_id = layer_get_id("Background");
				var back_id = layer_background_get_id(lay_id);
				layer_background_sprite(back_id, spr_workshop_nolight);
				global.updateable = music_pause;
			};
		},
		draw: function() {
			draw_set_alpha(1);
			draw_set_color(c_black);
			draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			tag_decorated_text_draw(tds, display_get_gui_width() / 2, display_get_gui_height() / 2);
		}
	}

	global.updateable = init;
	//global.updateable = cory_flys_back_to_perch;
}
