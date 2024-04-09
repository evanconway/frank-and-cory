shader = sh_test;

u_centre = shader_get_uniform(shader, "centre"); // in room coordinates
u_radius = shader_get_uniform(shader, "radius"); // in room pixels
u_feather = shader_get_uniform(shader, "feather"); // factor of radius >= 0 && <= 1

radius = 100;
feather = 0.75;

// layer_shader(layer_get_id("tlyr_punched"), shader); // seems unused
