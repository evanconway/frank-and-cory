event_inherited();

column = 0;

on_click = function() {
	podcast_machine_play_column(column);
}

original_draw = draw;

draw = function() {
	original_draw();
	if (global.updateable == global.podcast_player) {
		shader_set(sh_disable);
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_black, 1);
		shader_reset();
	}
};