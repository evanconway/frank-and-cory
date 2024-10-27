event_inherited();

original_draw = draw;

draw = function() {
	original_draw();
	if (global.updateable == global.podcast_player || global.updateable == global.podcast_test_player) {
		shader_set(sh_black);
		var uniform_alpha = shader_get_uniform(sh_black, "alpha");
		shader_set_uniform_f(uniform_alpha, 0.5);
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_black, 1);
		shader_reset();
	}
};
