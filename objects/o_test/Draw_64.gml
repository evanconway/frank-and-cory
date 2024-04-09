if (global.light_switch_on) return;

surface_set_target(clip_surface);
draw_clear_alpha(c_black, 1);

gpu_set_blendmode(bm_subtract);

draw_set_alpha(0.7);
draw_circle(mouse_x, mouse_y, 100, false);

gpu_set_blendmode(bm_normal);

surface_reset_target();
draw_set_alpha(1);
draw_surface(clip_surface, 0, 0);
