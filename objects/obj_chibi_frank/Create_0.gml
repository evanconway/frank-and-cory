event_inherited();

shader = undefined;

on_click = function() {
	play_sfx(snd_jude_mini_frank);
	shader = sh_red;
	global.updateable = {
		time: 0,
		changes: 0,
		update: function() {
			time += (delta_time / global.frame_time);
			if (time >= 12) {
				changes += 1;
				time = 0;
				if (obj_chibi_frank.shader == sh_red) {
					obj_chibi_frank.shader = sh_green;
				} else if (obj_chibi_frank.shader == sh_green) {
					obj_chibi_frank.shader = sh_blue;
				} else if (obj_chibi_frank.shader == sh_blue) {
					obj_chibi_frank.shader = sh_red;
				}
			}
			if (changes >= 10) {
				obj_chibi_frank.shader = undefined;
				global.updateable = undefined;
			}
		},
	};
};

draw = function() {
	draw_self();
	if (shader != undefined) {
		shader_set(shader);
		var uniform_alpha = shader_get_uniform(shader, "alpha");
		shader_set_uniform_f(uniform_alpha, 0.5);
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, 1);
		shader_reset();
	}
}
