event_inherited();

on_click = function() {
	var count = podcast_get_number_correct();
	
	var encourage = dialog_get_updateable([
		frank_get_dialog_step("Listen to them carefully and I'm sure you'll get it.", FRANK_EXPRESSION.PODCAST_BLANK_DOWN),
	]);
	
	if (count >= 4) encourage = dialog_get_updateable([
		frank_get_dialog_step($"You're getting there. Keep trying!", FRANK_EXPRESSION.PODCAST_LEFT_UP),
	]);
	
	if (count >= 8) encourage = dialog_get_updateable([
		frank_get_dialog_step($"You're so close. Don't give up!", FRANK_EXPRESSION.PODCAST_BLANK_PUMP),
	]);
	
	global.updateable = encourage;
};

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
