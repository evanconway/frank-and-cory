
var clicked = mouse_check_button_pressed(mb_any);
if (clicked && position_meeting(mouse_x, mouse_y, id)) {
	global.light_switch_on = !global.light_switch_on;
}


if (global.light_switch_on) image_index = 1;
else image_index = 0;

draw_self();
