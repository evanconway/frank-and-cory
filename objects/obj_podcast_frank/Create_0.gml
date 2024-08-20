event_inherited();

enum FRANK_PODCAST_EXPRESSION {
	NEUTRAL,
	SAD,
	LEFT,
	UPLEFT,
}

expression = FRANK_PODCAST_EXPRESSION.NEUTRAL;
disabled = true;
original_draw = draw;
draw = function() {
	original_draw();
	var eye_index = FRANK_PODCAST_EXPRESSION.NEUTRAL;
	if (expression == FRANK_PODCAST_EXPRESSION.NEUTRAL) eye_index = 0;
	if (expression == FRANK_PODCAST_EXPRESSION.SAD) eye_index = 1;
	if (expression == FRANK_PODCAST_EXPRESSION.LEFT) eye_index = 2;
	if (expression == FRANK_PODCAST_EXPRESSION.UPLEFT) eye_index = 3;
	draw_sprite(spr_podcast_frank_eyes, eye_index, x, y);
};
