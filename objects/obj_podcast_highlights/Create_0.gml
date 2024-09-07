event_inherited();
disabled = true;
highlight = undefined;
draw = function() {
	if (highlight != undefined) {
		draw_set_alpha(0.5);
		draw_sprite(highlight, 0, 0, 0);
	}
	highlight = undefined;
}
