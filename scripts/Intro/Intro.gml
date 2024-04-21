global.intro_blackout_alpha = 1;

global.intro_blackout_func = function() {
	draw_set_alpha(global.intro_blackout_alpha);
	draw_set_color(c_black);
	draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
};

function start_intro() {
	var oh_no_my_body_dialog = updateable_start_dialog([
		"Ah! My body! What happened to me?",
		"Geez, this place could use some spring cleaning, don't you think?",
		"Am I dying? Am I dead? Is this death?",
		"You're going to be okay. Just in a little shock is all. Heh. Get it?",
		"I don't.",
		"Do you remember anything before the outage?",
		"I don't even know who you are.",
		"Huh?"
	]);

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

	global.updateable = {
		opening_lines,
		update: function() {
			if (room != rm_workshop) return;
			global.updateable = opening_lines;
		},
		draw: global.intro_blackout_func,
	};
}
