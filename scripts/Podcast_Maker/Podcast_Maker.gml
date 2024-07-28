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
	if (ds_map_size(global.map_audio_reel_asset) > 0) return;
	
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
			if (draggable_at_position != noone) {
				draggable_at_position.image_angle -= 3;
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
				play_individual_column = false;
				global.updateable = undefined;
			} else {
				play_audio_at_current_column();
			}
		}
		
		with (obj_stop_all) update_clickable(id);
	},
};

function podcast_machine_play_all() {
	global.podcast_player.column_to_play = 0;
	global.updateable = global.podcast_player;
	global.podcast_player.play_audio_at_current_column();
};

function podcast_machine_stop_all() {
	global.podcast_player.stop_all();
	global.updateable = undefined;
}

function podcast_machine_play_column(column=0) {
	global.podcast_player.play_individual_column = true;
	global.podcast_player.column_to_play = column;
	global.updateable = global.podcast_player;
	global.podcast_player.play_audio_at_current_column();
}

function podcast_machine_transition() {
	global.updateable = {
		alpha: 0,
		step: 0,
		steps: [
			function() {
				alpha += 0.01;
				if (alpha >= 1) step++;
			},
			function() {
				room_goto(room == rm_podcast_machine ? rm_workshop : rm_podcast_machine);
				step++;
			},
			function() {
				alpha -= 0.01;
				if (alpha <= 0) global.updateable = undefined;
			},
		],
		update: function() {
			steps[step]();
		},
		draw: function() {
			draw_set_alpha(alpha);
			draw_set_color(c_black);
			draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
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
			var reel = ds_map_find_value(global.position_draggable_map, global.podcast_test_position);
			if (reel != noone) reel.image_angle -= 3;
		}
		update_clickable(obj_stop_test);
	}
};

function podcast_play_test() {
	if (!__podcast_ensure_test_position_exists()) return;
	play_sfx(global.podcast_test_player.get_audio_at_test());
	global.updateable = global.podcast_test_player;
}

function podcast_stop_test() {
	if (!__podcast_ensure_test_position_exists()) return;
	audio_stop_sound(global.podcast_test_player.get_audio_at_test());
	global.updateable = undefined;
}
