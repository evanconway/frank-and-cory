/* 
2D array of columns, then row.
Each entry is a draggable_position instance correlating with the position in the array
*/
global.podcast_tape_slots = [
	[inst_316D019, inst_539A57D8, inst_5E6A593],
	[inst_BEF507, inst_3A9D56AE, inst_51AF4FDE],
	[inst_2D0E8C1F, inst_22FEC13C, inst_3183B74B],
	[inst_4D144C3, inst_1202BE7A, inst_4633AB96]
];

global.map_audio_reel_asset = ds_map_create();

function podcast_maker_setup() {
	if (ds_map_size(global.map_audio_reel_asset) <= 0) {
		var audio_arr = array_shuffle([
			snd_reel_vox_1,
			snd_reel_vox_2,
			snd_reel_vox_3,
			snd_reel_vox_4,
			snd_reel_sfx_1,
			snd_reel_sfx_2,
			snd_reel_sfx_3,
			snd_reel_sfx_4,
			snd_reel_score_1,
			snd_reel_score_2,
			snd_reel_score_3,
			snd_reel_score_4,
		]);
	
		ds_map_set(global.map_audio_reel_asset, inst_7AAB43BD, audio_arr[0]);
		ds_map_set(global.map_audio_reel_asset, inst_25994B2C, audio_arr[1]);
		ds_map_set(global.map_audio_reel_asset, inst_1772A928, audio_arr[2]);
		ds_map_set(global.map_audio_reel_asset, inst_5AA3BDBA, audio_arr[3]);
		ds_map_set(global.map_audio_reel_asset, inst_2D775EEB, audio_arr[4]);
		ds_map_set(global.map_audio_reel_asset, inst_2B424FAD, audio_arr[5]);
		ds_map_set(global.map_audio_reel_asset, inst_20707053, audio_arr[6]);
		ds_map_set(global.map_audio_reel_asset, inst_586C1312, audio_arr[7]);
		ds_map_set(global.map_audio_reel_asset, inst_DBB61CD, audio_arr[8]);
		ds_map_set(global.map_audio_reel_asset, inst_C74BBA9, audio_arr[9]);
		ds_map_set(global.map_audio_reel_asset, inst_344345C4, audio_arr[10]);
		ds_map_set(global.map_audio_reel_asset, inst_49F5CA89, audio_arr[11]);
		show_debug_message("assigned audio assets to reel assets");
	}
	
	/*
	For all instances, we assign from visually bottom to top. That's because a higher depth
	appears further in the background. This we we can start at 0 for slots and reel positions.
	*/

	var anchor_depth = inst_483E17DC.depth;

	var calc_depth = anchor_depth;

	// slot cover depths
	with (inst_slot_1) {
		depth = calc_depth;
	}
	calc_depth += 2;
	with (inst_slot_2) {
		depth = calc_depth;
	}
	calc_depth += 2;
	with (inst_slot_3) {
		depth = calc_depth;
	}
	calc_depth += 2;
	with (inst_slot_4) {
		depth = calc_depth;
	}
	calc_depth += 2;
	with (inst_slot_5) {
		depth = calc_depth;
	}
	calc_depth += 2;
	with (inst_slot_6) {
		depth = calc_depth;
	}
	calc_depth += 2;
	with (inst_slot_7) {
		depth = calc_depth;
	}
	calc_depth += 2;
	with (inst_slot_8) {
		depth = calc_depth;
	}
	calc_depth += 2;
	with (inst_slot_9) {
		depth = calc_depth;
	}
	calc_depth += 2;
	with (inst_slot_10) {
		depth = calc_depth;
	}
	calc_depth += 2;
	with (inst_slot_11) {
		depth = calc_depth;
	}
	calc_depth += 2;
	with (inst_slot_12) {
		depth = calc_depth;
	}

	calc_depth = anchor_depth + 1;

	// slot position depths
	with (inst_483E17DC) {
		depth = calc_depth;
	}
	calc_depth += 2;
	with (inst_39A52F5D) {
		depth = calc_depth;
	}
	calc_depth += 2;
	with (inst_4BA96E74) {
		depth = calc_depth;
	}
	calc_depth += 2;
	with (inst_74E55344) {
		depth = calc_depth;
	}
	calc_depth += 2;
	with (inst_2CFDA4DC) {
		depth = calc_depth;
	}
	calc_depth += 2;
	with (inst_3362F9A) {
		depth = calc_depth;
	}
	calc_depth += 2;
	with (inst_7E344818) {
		depth = calc_depth;
	}
	calc_depth += 2;
	with (inst_2ECED215) {
		depth = calc_depth;
	}
	calc_depth += 2;
	with (inst_613DFC56) {
		depth = calc_depth;
	}
	calc_depth += 2;
	with (inst_4848D04A) {
		depth = calc_depth;
	}
	calc_depth += 2;
	with (inst_1C2B79B) {
		depth = calc_depth;
	}
	calc_depth += 2;
	with (inst_79C6C881) {
		depth = calc_depth;
	}

	var set_reel_data = function(reel=noone, reel_new_id=0, position=noone) {
		with (reel) {
			reel_id = reel_new_id;
			draggable_set_position(id, position);
			x = position.x;
			y = position.y;
			depth = position.depth;
		}
	};

	// reels
	set_reel_data(inst_7AAB43BD, 0, inst_79C6C881)
	set_reel_data(inst_586C1312, 7, inst_1C2B79B)
	set_reel_data(inst_1772A928, 2, inst_4848D04A)
	set_reel_data(inst_20707053, 6, inst_613DFC56)
	set_reel_data(inst_344345C4, 10, inst_2ECED215)
	set_reel_data(inst_49F5CA89, 11, inst_7E344818)
	set_reel_data(inst_C74BBA9, 9, inst_3362F9A)
	set_reel_data(inst_5AA3BDBA, 2, inst_2CFDA4DC)
	set_reel_data(inst_2B424FAD, 5, inst_74E55344)
	set_reel_data(inst_25994B2C, 1, inst_4BA96E74)
	set_reel_data(inst_DBB61CD, 8, inst_39A52F5D)
	set_reel_data(inst_2D775EEB, 4, inst_483E17DC)
}

function podcast_get_audio_at_column(column=0) {
	if (column < 0) return [snd_emptynoise];
	var tape_positions = global.podcast_tape_slots[column];
	var audio_at_position = array_map(tape_positions, function(position=noone) {
		var draggable_at_position = ds_map_find_value(global.position_draggable_map, position);
		var sound = ds_map_find_value(global.map_audio_reel_asset, draggable_at_position);
		return sound;
	});
	var audio_undefined_filtered = array_filter(audio_at_position, function(e) {
		return e != undefined;
	});
	return array_length(audio_undefined_filtered) == 0 ? [snd_emptynoise] : audio_undefined_filtered;
}

function podcast_get_is_complete() {
	var column_0_audio = podcast_get_audio_at_column(0);
	var column_1_audio = podcast_get_audio_at_column(1);
	var column_2_audio = podcast_get_audio_at_column(2);
	var column_3_audio = podcast_get_audio_at_column(3);
	var col_0_fin = array_contains_ext(column_0_audio, [snd_reel_vox_1, snd_reel_sfx_1, snd_reel_score_1], true);
	var col_1_fin = array_contains_ext(column_1_audio, [snd_reel_vox_2, snd_reel_sfx_2, snd_reel_score_2], true);
	var col_2_fin = array_contains_ext(column_2_audio, [snd_reel_vox_3, snd_reel_sfx_3, snd_reel_score_3], true);
	var col_3_fin = array_contains_ext(column_3_audio, [snd_reel_vox_4, snd_reel_sfx_4, snd_reel_score_4], true);
	return col_0_fin && col_1_fin && col_2_fin && col_3_fin;
};

function podcast_get_random_rotation_amount() {
	return random_range(1.5, 3.5);
}

/*
Playback will be an updateable. The machine is "playing audio" if the app updateable is set
to the podcast updateable.
*/

global.podcast_player = {
	play_individual_column: false, // when set true, the player will stop after playing the current column.
	column_to_play: 0,
	get_audio_at_current_column: function() {
		if (column_to_play < 0) return [snd_emptynoise];
		var tape_positions = global.podcast_tape_slots[column_to_play];
		var audio_at_position = array_map(tape_positions, function(position=noone) {
			var draggable_at_position = ds_map_find_value(global.position_draggable_map, position);
			var sound = ds_map_find_value(global.map_audio_reel_asset, draggable_at_position);
			return sound;
		});
		
		var audio_undefined_filtered = array_filter(audio_at_position, function(e) {
			return e != undefined;
		});
		
		return array_length(audio_undefined_filtered) == 0 ? [snd_emptynoise] : audio_undefined_filtered;
	},
	rotate_reels_at_current_column: function() {
		if (column_to_play < 0) return;
		var tape_positions = global.podcast_tape_slots[column_to_play];
		for (var i = 0; i < array_length(tape_positions); i++) {
			var draggable_at_position = ds_map_find_value(global.position_draggable_map, tape_positions[i]);
			var rotate = podcast_get_random_rotation_amount();
			tape_positions[i].image_angle -= rotate;
			if (draggable_at_position != noone) {
				draggable_at_position.image_angle -= rotate;
			}
		}
	},
	stop_all: function() {
		var audio_assets = get_audio_at_current_column();
		for (var i = 0; i < array_length(audio_assets); i++) {
			audio_stop_sound(audio_assets[i]);
		}
		column_to_play = -1;
	},
	play_audio_at_current_column: function() {
		show_debug_message($"playing audio at column {column_to_play}")
		var audio_assets = get_audio_at_current_column(column_to_play);
		for (var i = 0; i < array_length(audio_assets); i++) {
			play_sfx(audio_assets[i]);
		}
	},
	column_finished: function() {
		var audio_assets = get_audio_at_current_column();
		var finished = true;
		for (var i = 0; i < array_length(audio_assets); i++) {
			if (audio_is_playing(audio_assets[i])) finished = false;
		}
		return finished;
	},
	update: function() {		
		rotate_reels_at_current_column();
		
		if (column_finished()) {
			// forces end of play logic to trigger on play_individual_column
			if (play_individual_column) column_to_play = array_length(global.podcast_tape_slots);
			else column_to_play++;
			
			if (column_to_play >= array_length(global.podcast_tape_slots)) {
				// playing finished
				global.updateable = undefined;
			} else {
				play_audio_at_current_column();
			}
		}
		
		with (obj_stop_all) update_clickable(id);
	},
};

function podcast_machine_play_all() {
	audio_stop_sound(snd_music_tutorial);
	play_sfx(snd_jude_button_play, 1);
	global.podcast_player.column_to_play = 0;
	global.podcast_player.play_individual_column = false;
	global.updateable = global.podcast_player;
	global.podcast_player.play_audio_at_current_column();
};

function podcast_machine_play_column(column=0) {
	audio_stop_sound(snd_music_tutorial);
	play_sfx(snd_jude_button_play, 1);
	global.podcast_player.play_individual_column = true;
	global.podcast_player.column_to_play = column;
	global.updateable = global.podcast_player;
	global.podcast_player.play_audio_at_current_column();
}

/*
This just draws an image that looks like the podcast machine. It isn't the podcast machine itself.
Used for a descending animation for the transition.
*/
function podcast_machine_draw(x=0, y=0) {
	draw_set_alpha(1);
	draw_sprite(spr_podcast_machine, 0, x, y);
	
	draw_sprite(spr_tapereel, 0, x+793, y+333);
	draw_sprite(spr_podcast_machine_slot_12, 0, x, y);
	draw_sprite(spr_tapereel, 0, x+797, y+495);
	draw_sprite(spr_podcast_machine_slot_11, 0, x, y);
	draw_sprite(spr_tapereel, 0, x+800, y+671);
	draw_sprite(spr_podcast_machine_slot_10, 0, x, y);
	draw_sprite(spr_tapereel, 0, x+800, y+868);
	draw_sprite(spr_podcast_machine_slot_9, 0, x, y);
	draw_sprite(spr_tapereel, 0, x+794, y+1075);
	draw_sprite(spr_podcast_machine_slot_8, 0, x, y);
	draw_sprite(spr_tapereel, 0, x+799, y+1278);
	draw_sprite(spr_podcast_machine_slot_7, 0, x, y);
	draw_sprite(spr_tapereel, 0, x+788, y+1472);
	draw_sprite(spr_podcast_machine_slot_6, 0, x, y);
	draw_sprite(spr_tapereel, 0, x+794, y+1643);
	draw_sprite(spr_podcast_machine_slot_5, 0, x, y);
	draw_sprite(spr_tapereel, 0, x+794, y+1848);
	draw_sprite(spr_podcast_machine_slot_4, 0, x, y);
	draw_sprite(spr_tapereel, 0, x+795, y+2072);
	draw_sprite(spr_podcast_machine_slot_3, 0, x, y);
	draw_sprite(spr_tapereel, 0, x+785, y+2271);
	draw_sprite(spr_podcast_machine_slot_2, 0, x, y);
	draw_sprite(spr_tapereel, 0, x+787, y+2457);
	draw_sprite(spr_podcast_machine_slot_1, 0, x, y);
	
	draw_sprite(spr_empty_reel_slot, 0, x+1972, y+401);
	
	draw_sprite(spr_empty_reel_slot, 0, x+1626, y+1283);
	draw_sprite(spr_empty_reel_slot, 0, x+1623, y+1812);
	draw_sprite(spr_empty_reel_slot, 0, x+1624, y+2351);
	
	draw_sprite(spr_empty_reel_slot, 0, x+2303, y+1280);
	draw_sprite(spr_empty_reel_slot, 0, x+2302, y+1812);
	draw_sprite(spr_empty_reel_slot, 0, x+2304, y+2351);
	
	draw_sprite(spr_empty_reel_slot, 0, x+2957, y+1281);
	draw_sprite(spr_empty_reel_slot, 0, x+2956, y+1812);
	draw_sprite(spr_empty_reel_slot, 0, x+2958, y+2350);
	
	draw_sprite(spr_empty_reel_slot, 0, x+3647, y+1280);
	draw_sprite(spr_empty_reel_slot, 0, x+3646, y+1812);
	draw_sprite(spr_empty_reel_slot, 0, x+3647, y+2351);
	
	draw_sprite(spr_play_single_1, 0, x, y);
	draw_sprite(spr_play_single_2, 0, x, y);
	draw_sprite(spr_play_single_3, 0, x, y);
	draw_sprite(spr_play_single_4, 0, x, y);
	draw_sprite(spr_stop_column_1, 0, x, y);
	draw_sprite(spr_stop_column_2, 0, x, y);
	draw_sprite(spr_stop_column_3, 0, x, y);
	draw_sprite(spr_stop_column_4, 0, x, y);
	draw_sprite(spr_play_all, 0, x, y);
	draw_sprite(spr_stop_all, 0, x, y);
	draw_sprite(spr_play_single, 0, x, y);
	draw_sprite(spr_stop_single, 0, x, y);
}

function podcast_machine_transition() {
	play_sfx(snd_jude_mouse_run_1);
	
	var tutorial_d = dialog_get_updateable([		
		frank_get_dialog_step("Once everything's in the right order I'll let you know.", FRANK_EXPRESSION.PODCAST_UP_PUMP),
		cory_get_dialog_step("Good luck!", CORY_EXPRESSION.PODCAST_WINGS),
	]);
	
	var highlight_test = dialog_get_updateable([
		cory_get_dialog_step("Drag it to this test area for a listen!", CORY_EXPRESSION.PODCAST_WINGS),
	], {
		on_step_all: function() {
			obj_podcast_highlights.highlight = spr_podcast_machine_highlight_test;
		},
		after_dialog_updateable: tutorial_d,
	})
	
	var tutorial_c = dialog_get_updateable([		
		cory_get_dialog_step("And if you want to hear a reel by itself...", CORY_EXPRESSION.PODCAST_HIP),
	], {
		after_dialog_updateable: highlight_test,
	});
	
	var highlight_chapters = dialog_get_updateable([
		frank_get_dialog_step("Put the reels here to build the story.", FRANK_EXPRESSION.PODCAST_UP_UP),
	], {
		on_step_all: function() {
			obj_podcast_highlights.highlight = spr_podcast_machine_highlight_chapters;
		},
		after_dialog_updateable: tutorial_c,
	});
	
	var tutorial_b = dialog_get_updateable([
		frank_get_dialog_step("I hope you like the synthesized human voice.", FRANK_EXPRESSION.PODCAST_LEFT_PUMP),
		frank_get_dialog_step("Click and drag to pick up a reel.", FRANK_EXPRESSION.PODCAST_LEFT_UP),
		frank_get_dialog_step("Move it to a slot and release to place it.", FRANK_EXPRESSION.PODCAST_LEFT_DOWN),
	], {
		after_dialog_updateable: highlight_chapters,
	});
	
	var highlight_reels = dialog_get_updateable([
		frank_get_dialog_step("Those reels are right here!", FRANK_EXPRESSION.PODCAST_BLANK_UP),
	], {
		on_step_all: function() {
			obj_podcast_highlights.highlight = spr_podcast_machine_highlight_rack;
		},
		after_dialog_updateable: tutorial_b,
	});
	
	var tutorial_a = dialog_get_updateable([
		cory_get_dialog_step("Let's build this story!", CORY_EXPRESSION.PODCAST_WINGS),
		frank_get_dialog_step("Oh", FRANK_EXPRESSION.PODCAST_LEFT_DOWN),
		frank_get_dialog_step("This is my favorite part!", FRANK_EXPRESSION.PODCAST_UP_PUMP),
		cory_get_dialog_step("This story has 4 chapters.", CORY_EXPRESSION.PODCAST_HIP),
		cory_get_dialog_step("Each needs a voice, music, and sound effects reel.", CORY_EXPRESSION.PODCAST_NEUTRAL),
	], {
		after_dialog_updateable: highlight_reels,
	});
	
	// feather disable GM1043
	global.updateable = {
		tutorial_a,
		draw_machine: true,
		step: 0,
		vertical_offset: display_get_gui_height(),
		time: 0,
		steps: [
			function() {	
				obj_workshop_cory.x += 100;
				obj_frank_chest.x -= 100;
				if (obj_workshop_cory.x > 2000 && obj_frank_chest.x < 2000) {
					step += 1;
					play_sfx(snd_jude_podcast_machine_descend);
					play_sfx(snd_music_podcast_transition, 1);
				}
			},
			function() {
				vertical_offset -= min(6, vertical_offset * 0.1);
				
				if (abs(vertical_offset) < 1) {
					vertical_offset = 0;
					step += 1;
				}
			},
			function() {
				room_goto(room == rm_podcast_machine ? rm_workshop : rm_podcast_machine);
				step += 1;
			},
			function() {
				if (room == rm_podcast_machine) {
					global.cory_dialog_position = CORY_DIALOG_POSITION.PODCAST;
					global.frank_dialog_position = FRANK_DIALOG_POSITION.PODCAST;
					global.frank_expression = FRANK_EXPRESSION.PODCAST_LEFT_DOWN;
					global.frank_idle_expression = FRANK_EXPRESSION.PODCAST_LEFT_DOWN;
					obj_podcast_cory.x = -1000;
					obj_podcast_frank.x = 1000;
					
					// reset rell positions
					podcast_maker_setup();
					
					draw_machine = false;
					step += 1;
				}
			},
			function() {
				time += 1;
				if (time > 120) {
					step += 1;
					time = 0;
					play_sfx(snd_jude_mouse_run_1);
				}
			},
			function() {
				obj_podcast_cory.x = min(0, obj_podcast_cory.x + 50);
				obj_podcast_frank.x = max(0, obj_podcast_frank.x - 50);
				if (obj_podcast_cory.x == 0 && obj_podcast_frank.x == 0) {
					step += 1;
				}
			},
			function() {
				time += 1;
				if (time > 45) {
					global.updateable = tutorial_a;
					play_sfx(snd_music_tutorial, 1, 1, true);
				}
			}
		],
		update: function() {
			steps[step]();
		},
		draw: function() {
			if (draw_machine) podcast_machine_draw(0, vertical_offset * -1);
		}
	};
}

global.podcast_test_position = inst_14DD30FB;

function __podcast_ensure_test_position_exists() {
	var result = instance_exists(global.podcast_test_position);
	if (!result) show_debug_message("referencing test position when it doesn't exist!");
	return result;
}

global.podcast_test_player = {	
	get_audio_at_test: function() {
		var reel = ds_map_find_value(global.position_draggable_map, global.podcast_test_position);
		if (reel == noone) return snd_emptynoise;
		var sound = ds_map_find_value(global.map_audio_reel_asset, reel);
		return sound;
	},
	update: function() {
		if (!audio_is_playing(get_audio_at_test())) {
			global.updateable = undefined;
		} else {
			var rotate = podcast_get_random_rotation_amount();
			global.podcast_test_position.image_angle -= rotate;
			var reel = ds_map_find_value(global.position_draggable_map, global.podcast_test_position);
			if (reel != noone) reel.image_angle -= rotate;
		}
		update_clickable(obj_stop_test);
	}
};

function podcast_play_test() {
	if (!__podcast_ensure_test_position_exists()) return;
	audio_stop_sound(snd_music_tutorial);
	play_sfx(snd_jude_button_play, 1);
	play_sfx(global.podcast_test_player.get_audio_at_test());
	global.podcast_player.column_to_play = -2;
	global.updateable = global.podcast_test_player;
}


function podcast_machine_stop_all() {
	play_sfx(snd_jude_button_stop, 1);
	if (__podcast_ensure_test_position_exists()) {
		var test_snd = global.podcast_test_player.get_audio_at_test();
		if (test_snd != undefined) audio_stop_sound(test_snd);
	}
	global.podcast_player.stop_all();
	global.updateable = undefined;
}
