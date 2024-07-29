event_inherited();

disabled = true;

original_draw = draw;

draw = function() {
	visible = global.frank_attached_arms && !global.frank_attached_legs;
	original_draw();
};
