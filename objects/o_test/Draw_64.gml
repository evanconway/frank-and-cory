/// @description set shader

shader_set(shader);
shader_set_uniform_f(u_centre, mouse_x, mouse_y);
shader_set_uniform_f(u_radius, radius);
shader_set_uniform_f(u_feather, feather);

draw_set_alpha(1);
draw_set_color(c_black);
draw_rectangle(0, 0, window_get_width(), window_get_height(), false);

shader_reset();
