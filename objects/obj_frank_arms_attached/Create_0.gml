event_inherited();

disabled = true;

original_draw = draw;

draw = function() {
	visible = global.frank_attached_arms;
	original_draw();
};
