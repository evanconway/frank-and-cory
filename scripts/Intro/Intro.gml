global.intro_blackout_alpha = 1;
global.light_switch_on = false;

global.intro_blackout_func = function() {
	draw_set_alpha(global.intro_blackout_alpha);
	draw_set_color(c_black);
	draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
};

function start_intro() {
	var cory_knows_somethings_up = updateable_start_dialog([
		"Okay. Something's not right.",
		"Hey. What are you doing back there? Get away from me!",
		"Oh. I see it now.",
		"What is it? What do you see?",
		"There's a little rectangle back here that says \"memory\".",
		"What's a memory?",
		"Hah. Good one.",
		"Good what?",
		"Oh. You're being serious. Never mind.",
		"Maybe if I can find the piece that fits in this spot, we'll get you back to your normal self.",
	], undefined, function () {}, function() {
		obj_workshop_cory.image_index = 1;
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
			position_start: { x: 2953, y: -234 },
			position_end: { x: 453,y: 1000 },
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
	
	var oh_no_my_body_dialog = updateable_start_dialog([
		"Ah! My body! What happened to me?",
		"Geez, this place could use some spring cleaning, don't you think?",
		"Am I dying? Am I dead? Is this death?",
		"You're going to be okay. Just in a little shock is all. Heh. Get it?",
		"I don't.",
		"Do you remember anything before the outage?",
		"I don't even know who you are.",
		"Huh?"
	], cory_flys_to_head);

	var brief_pause = {
		oh_no_my_body_dialog,
		time: 0,
		update: function() {
			time += 1;
			if (time > 60) global.updateable = oh_no_my_body_dialog;
		},
	}

	var find_breaker_mini_game = {
		brief_pause,
		update: function() {
			if (global.flashlight_on == false) {
				global.flashlight_on = true;
				play_sfx(snd_button, 1, 0.9);
			}
			with (obj_light_switch) {
				if (position_meeting(mouse_x, mouse_y, id)) global.clickable_hovered = id;
				if (mouse_check_button_pressed(mb_any) && global.clickable_hovered == id) {
					global.light_switch_on = true;
					play_sfx(snd_button, 1, 1.2);
					global.updateable = other.brief_pause;
				};
			}
		},
		draw: function() {
			with (obj_light_switch) {
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

	var find_breaker_dialog = updateable_start_dialog([
		"Who's Frank?",
		"Geez, that power outage must have really knocked you out good.",
		"Why can't I feel my arms?",
		"One sec, I'm looking for the breaker box."
	], find_breaker_mini_game, darkness);

	var cory_light_fade = {
		find_breaker_dialog,
		update: function() {
			global.cory_light_alpha += 0.01;
			if (global.cory_light_alpha >= 1) {
				global.updateable = find_breaker_dialog;
			}
		},
		draw: darkness,
	};

	var cory_responds = updateable_start_dialog([
		"Oh. I must have fallen asleep.",
		"Frank!",
		"Huh?",
		"Are you alright?",
		"Where's that voice coming from?",
		"Frank! Over here!",
	], cory_light_fade, darkness);

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

	var opening_lines = updateable_start_dialog([
		"Huh?", 
		"Oh...",
		"Where am I?",
	], fade_in_scene, global.intro_blackout_func);

	var init = {
		opening_lines,
		update: function() {
			if (room != rm_workshop) return;
			global.updateable = opening_lines;
		},
		draw: global.intro_blackout_func,
	}

	global.updateable = cory_flys_to_head;
}
