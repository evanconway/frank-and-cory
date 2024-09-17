event_inherited();

original_draw = draw;
draw = function() {
	if (array_contains([
		FRANK_EXPRESSION.PODCAST_LEFT_DOWN,
		FRANK_EXPRESSION.PODCAST_BLANK_DOWN,
		FRANK_EXPRESSION.PODCAST_SAD_DOWN,
		FRANK_EXPRESSION.PODCAST_UP_DOWN,
	], global.frank_expression)) image_index = 0;
		if (array_contains([
		FRANK_EXPRESSION.PODCAST_LEFT_UP,
		FRANK_EXPRESSION.PODCAST_BLANK_UP,
		FRANK_EXPRESSION.PODCAST_SAD_UP,
		FRANK_EXPRESSION.PODCAST_UP_UP,
	], global.frank_expression)) image_index = 1;
		if (array_contains([
		FRANK_EXPRESSION.PODCAST_LEFT_PUMP,
		FRANK_EXPRESSION.PODCAST_BLANK_PUMP,
		FRANK_EXPRESSION.PODCAST_SAD_PUMP,
		FRANK_EXPRESSION.PODCAST_UP_PUMP,
	], global.frank_expression)) image_index = 2;
	original_draw();
	if (global.frank_podcast_hair_attached) {
		draw_set_alpha(1);
		draw_sprite(spr_podcast_frank_hair, 0, 0, 0);
	}
	frank_draw_expression();
};
