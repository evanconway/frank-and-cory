event_inherited();
disabled = true;
highlight = undefined;
draw = function() {
	if (highlight != undefined) {
		draw_sprite_ext(highlight, 0, 0, 0, 1, 1, 0, c_white, 0.5);
	}
	highlight = undefined;
}
