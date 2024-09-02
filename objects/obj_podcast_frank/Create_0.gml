event_inherited();

disabled = true;
original_draw = draw;
draw = function() {
	original_draw();
	frank_draw_expression();
};
