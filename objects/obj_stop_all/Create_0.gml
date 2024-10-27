event_inherited();

on_click = podcast_machine_stop_all;

/*
Determines which column this stop button applies to
0-3: columns
-1: stop all
*/
column = -1;

pre_update = function() {
	disabled = true;
	// play_individual_column: false, // when set true, the player will stop after playing the current column.
	// column_to_play: 0,
	if (global.updateable != global.podcast_player || global.updateable == global.podcast_test_player) return;
	
	var is_playing_individual_col = global.podcast_player.play_individual_column;
	
	// podcast player is playing individual column
	if (column >= 0 && column <= 3) {
		if (is_playing_individual_col && global.podcast_player.column_to_play == column) {
			disabled = false;
			return;
		}
	}
	
	// podcast player is playing all
	if (column == -1) {
		if (!is_playing_individual_col) {
			disabled = false;
			return;
		}
	}
};

original_draw = draw;

draw = function() {
	original_draw();
	if (disabled) {
		shader_set(sh_black);
		var uniform_alpha = shader_get_uniform(sh_black, "alpha");
		shader_set_uniform_f(uniform_alpha, 0.5);
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_black, 1);
		shader_reset();
	}
};
