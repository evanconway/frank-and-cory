var hover = position_meeting(mouse_x, mouse_y, id);
var clicked = mouse_check_button_pressed(mb_any);
if (clicked && hover) on_click();
pre_draw();
draw();
if (hover) {
	shader_set(sh_hovered);
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, 1);
	shader_reset();
}
