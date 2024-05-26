/* 
2D array of columns, then row.
Each entry is a draggable_position instance correlating with the position in the array
*/
global.podcast_tape_slots = [
	[inst_47A5ECE1, inst_441D2DF8, inst_184B9ABB],
	[inst_DA9FA42, inst_D29D9CA, inst_7A60690D],
	[inst_46120EEE, inst_284C1728, inst_E709F0E],
	[inst_32549BBF, inst_2766369, inst_5C163404]
];

global.map_audio_reel_asset = ds_map_create();

function podcast_maker_setup() {
	ds_map_set(global.map_audio_reel_asset, inst_7AAB43BD, snd_reel_1);
	ds_map_set(global.map_audio_reel_asset, inst_25994B2C, snd_reel_2);
	ds_map_set(global.map_audio_reel_asset, inst_1772A928, snd_reel_3);
	ds_map_set(global.map_audio_reel_asset, inst_5AA3BDBA, snd_reel_4);
	ds_map_set(global.map_audio_reel_asset, inst_2D775EEB, snd_reel_5);
	ds_map_set(global.map_audio_reel_asset, inst_2B424FAD, snd_reel_6);
	ds_map_set(global.map_audio_reel_asset, inst_20707053, snd_reel_7);
	ds_map_set(global.map_audio_reel_asset, inst_586C1312, snd_reel_8);
	ds_map_set(global.map_audio_reel_asset, inst_DBB61CD, snd_reel_9);
	ds_map_set(global.map_audio_reel_asset, inst_C74BBA9, snd_reel_10);
	ds_map_set(global.map_audio_reel_asset, inst_344345C4, snd_reel_11);
	ds_map_set(global.map_audio_reel_asset, inst_49F5CA89, snd_reel_12);
}

/*
Playback will be an updateable. The machine is "playing audio" if the app updateable is set
to the podcast updateable.
*/

global.podcast_player = {
	column_to_play: -1,
	get_audio_at_current_column: function() {
		if (column_to_play < 0) return [snd_emptynoise];
		podcast_maker_setup();
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
		podcast_maker_setup();
		var tape_positions = global.podcast_tape_slots[column_to_play];
		for (var i = 0; i < array_length(tape_positions); i++) {
			var draggable_at_position = ds_map_find_value(global.position_draggable_map, tape_positions[i]);
			if (draggable_at_position != noone) {
				draggable_at_position.image_angle -= 2;
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
		if (column_to_play == -1) {
			column_to_play = 0;
			play_audio_at_current_column();
		}
		
		rotate_reels_at_current_column();
		
		if (column_finished()) {
			column_to_play++;
			if (column_to_play >= array_length(global.podcast_tape_slots)) {
				// playing finished
				global.podcast_player.column_to_play = -1;
				global.updateable = undefined;
			} else {
				play_audio_at_current_column();
			}
		}
		
		with (obj_stop_all) update_clickable(id);
	},
};

function podcast_machine_play_all() {
	global.podcast_player.column_to_play = -1;
	global.updateable = global.podcast_player;
};

function podcast_machine_stop_all() {
	global.podcast_player.stop_all();
	global.updateable = undefined;
}
