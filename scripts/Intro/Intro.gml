global.intro_blackout_alpha = 1;
global.breaker_open = false;
global.light_switch_on = false;

global.intro_frank_dialog_set_position = function() {
	global.dialog_position_x = 1690;
	global.dialog_position_y = 1975;
};

global.intro_cory_dialog_set_position = function() {
	global.dialog_position_x = 3100;
	global.dialog_position_y = 505;
};

global.intro_cory_dialog_set_position_head = function() {
	global.dialog_position_x = 1270;
	global.dialog_position_y = 1080;
};

global.intro_blackout_func = function() {
	draw_set_alpha(global.intro_blackout_alpha);
	draw_set_color(c_black);
	draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
};

function start_intro() {
	var get_frank_step = global.frank_get_dialog_step;
	
	var get_cory_step = function(text, position=0) {
		return {
			text,
			on_step: position == 0 ? global.intro_cory_dialog_set_position : global.intro_cory_dialog_set_position_head,
			default_effects: "f:fnt_ally t:80,2 cp:,,420 cp:;,420 cp:.,520 cp:!,520 cp:?,520",
		}
	};
	
	var cory_knows_somethings_up = dialog_get_updateable([
		get_cory_step("Okay. Something's not right.", 1),
		get_frank_step("Hey. What are you doing back there? Get away from me!", FRANK_EXPRESSION.UP),
		get_cory_step("Oh. I see it now.", 1),
		get_frank_step("What is it? What do you see?", FRANK_EXPRESSION.BLANK),
		get_cory_step("There's a little rectangle back here that says \"memory\".", 1),
		get_frank_step("What's a memory?", FRANK_EXPRESSION.UP),
		get_cory_step("Hah. Good one.", 1),
		get_frank_step("Good what?", FRANK_EXPRESSION.RIGHT),
		get_cory_step("Oh. You're being serious. Never mind.", 1),
		get_cory_step("Maybe if I can find the piece that fits in this spot, we'll get you back to your normal self.", 1)
	],{
		on_step_all:  function() {
			obj_workshop_cory.image_index = 1;
		}
	});
	
	var cory_taps_head = {
		cory_knows_somethings_up,
		time: 0,
		step: 0,
		steps: [
			function() {
				obj_workshop_cory.image_index = 1;
				if (time > 45) {
					time = 0;
					step++;
					obj_workshop_cory.image_index = 2;
					play_sfx(snd_type);
				}
			},
			function() {
				obj_workshop_cory.image_index = 2;
				if (time > 10) {
					time = 0;
					step++;
				}
			},
			function() {
				obj_workshop_cory.image_index = 1;
				if (time > 10) {
					time = 0;
					step++;
					obj_workshop_cory.image_index = 2;
					play_sfx(snd_type);
				}
			},
			function() {
				obj_workshop_cory.image_index = 2;
				if (time > 10) {
					time = 0;
					step++;
				}
			},
			function() {
				obj_workshop_cory.image_index = 1;
				if (time > 60) {
					global.updateable = cory_knows_somethings_up;
				}
			},
		],
		update: function() {
			time += 1;
			steps[step]();
		},
	};
	
	var cory_flys_to_head = {
		cory_taps_head,
		// flight position is line function
		flight: {
			position_start: { x: 4080, y: -240 },
			position_end: { x: 645,y: 912 },
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
			flight.progress += 0.015;
			if (flight.progress >= 1) {
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
		get_frank_step("Ah! My body! What happened to me?", FRANK_EXPRESSION.BLANK),
		get_cory_step("Geez, this place could use some spring cleaning, don't you think?"),
		get_frank_step("Am I dying? Am I dead? Is this death?", FRANK_EXPRESSION.UP),
		get_cory_step("You're going to be okay. Just in a little shock is all. Heh. Get it?"),
		get_frank_step("I don't.", FRANK_EXPRESSION.UNAMUSED),
		get_cory_step("Do you remember anything before the outage?"),
		get_frank_step("I don't even know who you are.", FRANK_EXPRESSION.RIGHT),
		get_cory_step("Huh?")
	], { after_dialog_updateable: cory_flys_to_head });

	var brief_pause = {
		oh_no_my_body_dialog,
		time: 0,
		update: function() {
			time += 1;
			if (time > 60) global.updateable = oh_no_my_body_dialog;
		},
	}

	// this feels hacky, review later
	global.find_breaker_mini_game = {
		brief_pause,
		update: function() {
			global.frank_expression = FRANK_EXPRESSION.NEUTRAL;
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
					global.light_switch_on = true;
					play_sfx(snd_button, 1, 1.2);
					global.updateable = other.brief_pause;
					var lay_id = layer_get_id("Background");
					var back_id = layer_background_get_id(lay_id);
					layer_background_sprite(back_id, spr_workshop);
				};
			}
			if (!breaker_clicked) with (obj_clickable) {
				if (position_meeting(mouse_x, mouse_y, id) && mouse_check_button_pressed(mb_any)) {
					global.updateable = dialog_get_updateable(["I don't think that's right."], {
						after_dialog_updateable: global.find_breaker_mini_game,
						pre_dialog_draw: function() {
							darkness();
							global.intro_cory_dialog_set_position();
						},
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
		get_frank_step("Who is... Frank?", FRANK_EXPRESSION.BLANK),
		get_cory_step("Geez, that power outage must have really knocked you out good."),
		get_frank_step("Why can't I feel my arms?", FRANK_EXPRESSION.UP),
		get_cory_step("One sec, I'm looking for the breaker box.")
	], { after_dialog_updateable: global.find_breaker_mini_game, pre_dialog_draw: darkness });

	var cory_light_fade = {
		find_breaker_dialog,
		update: function() {
			global.frank_expression = FRANK_EXPRESSION.RIGHT
			global.cory_light_alpha += 0.01;
			if (global.cory_light_alpha >= 1) {
				global.updateable = find_breaker_dialog;
			}
		},
		draw: darkness,
	};

	var cory_responds = dialog_get_updateable([
		get_frank_step("Oh. I must have fallen asleep.", FRANK_EXPRESSION.UNAMUSED),
		get_cory_step("Frank!"),
		get_frank_step("Huh?", FRANK_EXPRESSION.RIGHT),
		get_cory_step("Are you alright?"),
		get_frank_step("Where's that voice coming from?", FRANK_EXPRESSION.UP),
		get_cory_step("Frank! Over here!")
	], { after_dialog_updateable: cory_light_fade, pre_dialog_draw: darkness });

	var fade_in_scene = {
		cory_responds,
		update: function() {
			global.intro_blackout_alpha -= 0.01;
			if (global.intro_blackout_alpha > 0) return;
			global.intro_blackout_alpha = 0;
			global.updateable = cory_responds;
		},
		draw: function() {
			darkness();
			global.intro_blackout_func()
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
			global.intro_blackout_func();
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
			time += 1;
			if (time > 60) global.updateable = opening_lines;
		},
		draw: global.intro_blackout_func,
	};

	var init = {
		small_pause,
		tds: new TagDecoratedTextDefault("click to start", "f:fnt_ally fade"),
		update: function() {
			if (room != rm_workshop) return;
			if (mouse_check_button_pressed(mb_any)) {
				var lay_id = layer_get_id("Background");
				var back_id = layer_background_get_id(lay_id);
				layer_background_sprite(back_id, spr_workshop_nolight);
				global.updateable = small_pause;
			};
		},
		draw: function() {
			global.intro_blackout_func();
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			tag_decorated_text_draw(tds, display_get_gui_width() / 2, display_get_gui_height() / 2);
		}
	}

	global.updateable = init;
}
