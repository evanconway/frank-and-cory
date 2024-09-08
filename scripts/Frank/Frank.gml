enum FRANK_EXPRESSION {
	BLANK,
	NEUTRAL,
	HAPPY,
	RIGHT,
	UP,
	UNAMUSED,
	DOWNLEFT,
	LEFT,
	// podcast: eyes, arms
	PODCAST_BLANK_DOWN,
	PODCAST_SAD_DOWN,
	PODCAST_LEFT_DOWN, 
	PODCAST_UP_DOWN,
	PODCAST_BLANK_UP,
	PODCAST_SAD_UP,
	PODCAST_LEFT_UP, 
	PODCAST_UP_UP,
	PODCAST_BLANK_PUMP,
	PODCAST_SAD_PUMP,
	PODCAST_LEFT_PUMP, 
	PODCAST_UP_PUMP,
}

global.frank_expression = FRANK_EXPRESSION.BLANK;

global.frank_sounds = [
	snd_jude_frank_chirp_1,
	// snd_jude_frank_chirp_2,
	snd_jude_frank_chirp_3,
	snd_jude_frank_chirp_4,
	snd_jude_frank_chirp_5,
	snd_jude_frank_chirp_6,
	// snd_jude_frank_chirp_7,
	// snd_jude_frank_chirp_8,
	snd_jude_frank_chirp_9,
	snd_jude_frank_chirp_10,
	snd_jude_frank_chirp_11,
];

global.frank_speaks = function() {
	var sounds = global.frank_sounds;
	for (var i = 0; i < array_length(sounds); i++) {
		audio_stop_sound(sounds[i]);
	}
	var snd_id = play_sfx(sounds[irandom_range(0, array_length(sounds) - 1)], 1, random_range(1.2, 1.6));
}

enum FRANK_DIALOG_POSITION {
	INTRO_HEAD,
	ASSEMBLED_PARTLY,
	ASSEMBLED_FULL,
	PODCAST,
}

global.frank_dialog_position = FRANK_DIALOG_POSITION.INTRO_HEAD;

function frank_get_dialog_step(text, expression=FRANK_EXPRESSION.NEUTRAL) {
	return {
		text,
		on_step: method({ expression }, function() {
			if (global.frank_dialog_position == FRANK_DIALOG_POSITION.INTRO_HEAD) {
				global.dialog_position_x = 2320;
				global.dialog_position_y = 2171;
			}
			if (global.frank_dialog_position == FRANK_DIALOG_POSITION.ASSEMBLED_PARTLY) {
				global.dialog_position_x = 2665;
				global.dialog_position_y = 505;
			}
			if (global.frank_dialog_position == FRANK_DIALOG_POSITION.ASSEMBLED_FULL) {
				global.dialog_position_x = 2100;
				global.dialog_position_y = 375;
			}
			if (global.frank_dialog_position == FRANK_DIALOG_POSITION.PODCAST) {
				global.dialog_position_x = 3109;
				global.dialog_position_y = 1553;
			}
			global.frank_expression = expression;
		}),
		on_type: global.frank_speaks,
		default_effects: "black f:fnt_ally t:160,4 cp:,,420 cp:;,420 cp:.,520 cp:!,520 cp:?,520",
		pre_dialog_draw: function() {
			var word_balloon = undefined;
			if (global.frank_dialog_position = FRANK_DIALOG_POSITION.INTRO_HEAD) word_balloon = spr_word_balloon_frank_left;
			if (global.frank_dialog_position = FRANK_DIALOG_POSITION.ASSEMBLED_PARTLY) word_balloon = spr_word_balloon_frank_left;
			if (global.frank_dialog_position = FRANK_DIALOG_POSITION.ASSEMBLED_FULL) word_balloon = spr_word_balloon_frank_left;
			if (global.frank_dialog_position = FRANK_DIALOG_POSITION.PODCAST) word_balloon = spr_word_balloon_frank_right;
			draw_set_alpha(1);
			if (word_balloon != undefined) draw_sprite(word_balloon, 0, global.dialog_position_x, global.dialog_position_y);
		}
	}
};

global.frank_memory_chip_added = false;
global.frank_attached_arms = false;
global.frank_attached_head = false;
global.frank_attached_legs = false;

global.frank_idle_expression_options = [
	FRANK_EXPRESSION.NEUTRAL,
	FRANK_EXPRESSION.RIGHT,
	FRANK_EXPRESSION.UP,
	FRANK_EXPRESSION.LEFT,
	FRANK_EXPRESSION.DOWNLEFT
];
global.frank_idle_expression_options_podcast = [
	FRANK_EXPRESSION.PODCAST_BLANK_DOWN,
	FRANK_EXPRESSION.PODCAST_LEFT_DOWN,
	FRANK_EXPRESSION.PODCAST_UP_DOWN,
];
global.frank_idle_expression = FRANK_EXPRESSION.NEUTRAL;
global.frank_idle_expression_time = 80;

function frank_draw_expression(x_left=271, y_left=166, x_right=271, y_right=166) {
	if (global.updateable == undefined) {
		global.frank_idle_expression_time -= 1;
		if (global.frank_idle_expression_time < 0) {
			global.frank_idle_expression_time = irandom_range(80, 140);
			var options = array_filter(room == rm_workshop ? global.frank_idle_expression_options : global.frank_idle_expression_options_podcast, function(option) {
				return option != global.frank_idle_expression;
			});
			global.frank_idle_expression = options[irandom_range(0, array_length(options) - 1)];
		}
		global.frank_expression = global.frank_idle_expression;
	}
	draw_set_alpha(1);
	draw_set_color(c_white);
	
	// left
	if (global.frank_expression == FRANK_EXPRESSION.NEUTRAL) draw_sprite(spr_frank_eyes_left, 4, x_left, y_left);
	if (global.frank_expression == FRANK_EXPRESSION.HAPPY) draw_sprite(spr_frank_eyes_left, 1, x_left, y_left);
	if (global.frank_expression == FRANK_EXPRESSION.BLANK) draw_sprite(spr_frank_eyes_left, 0, x_left, y_left);
	if (global.frank_expression == FRANK_EXPRESSION.RIGHT) draw_sprite(spr_frank_eyes_left, 2, x_left, y_left);
	if (global.frank_expression == FRANK_EXPRESSION.UNAMUSED) draw_sprite(spr_frank_eyes_left, 5, x_left, y_left);
	if (global.frank_expression == FRANK_EXPRESSION.UP) draw_sprite(spr_frank_eyes_left, 3, x_left, y_left);
	if (global.frank_expression == FRANK_EXPRESSION.DOWNLEFT) draw_sprite(spr_frank_eyes_left, 6, x_left, y_left);
	if (global.frank_expression == FRANK_EXPRESSION.LEFT) draw_sprite(spr_frank_eyes_left, 7, x_left, y_left);
	
	// right
	if (global.frank_expression == FRANK_EXPRESSION.NEUTRAL) draw_sprite(spr_frank_eyes_right, 4, x_right, y_right);
	if (global.frank_expression == FRANK_EXPRESSION.HAPPY) draw_sprite(spr_frank_eyes_right, 1, x_right, y_right);
	if (global.frank_expression == FRANK_EXPRESSION.BLANK) draw_sprite(spr_frank_eyes_right, 0, x_right, y_right);
	if (global.frank_expression == FRANK_EXPRESSION.RIGHT) draw_sprite(spr_frank_eyes_right, 2, x_right, y_right);
	if (global.frank_expression == FRANK_EXPRESSION.UNAMUSED) draw_sprite(spr_frank_eyes_right, 5, x_right, y_right);
	if (global.frank_expression == FRANK_EXPRESSION.UP) draw_sprite(spr_frank_eyes_right, 3, x_right, y_right);
	if (global.frank_expression == FRANK_EXPRESSION.DOWNLEFT) draw_sprite(spr_frank_eyes_right, 6, x_right, y_right);
	if (global.frank_expression == FRANK_EXPRESSION.LEFT) draw_sprite(spr_frank_eyes_right, 7, x_right, y_right);
	
	// podcast
	if (room == rm_podcast_machine) {
		if (array_contains([FRANK_EXPRESSION.PODCAST_BLANK_DOWN, FRANK_EXPRESSION.PODCAST_BLANK_PUMP, FRANK_EXPRESSION.PODCAST_BLANK_UP], global.frank_expression)) draw_sprite(spr_podcast_frank_eyes, 0, obj_podcast_frank.x, obj_podcast_frank.y);
		if (array_contains([FRANK_EXPRESSION.PODCAST_SAD_DOWN, FRANK_EXPRESSION.PODCAST_SAD_PUMP, FRANK_EXPRESSION.PODCAST_SAD_UP], global.frank_expression)) draw_sprite(spr_podcast_frank_eyes, 1, obj_podcast_frank.x, obj_podcast_frank.y);
		if (array_contains([FRANK_EXPRESSION.PODCAST_LEFT_DOWN, FRANK_EXPRESSION.PODCAST_LEFT_PUMP, FRANK_EXPRESSION.PODCAST_LEFT_UP], global.frank_expression)) draw_sprite(spr_podcast_frank_eyes, 2, obj_podcast_frank.x, obj_podcast_frank.y);
		if (array_contains([FRANK_EXPRESSION.PODCAST_UP_DOWN, FRANK_EXPRESSION.PODCAST_UP_PUMP, FRANK_EXPRESSION.PODCAST_UP_UP], global.frank_expression)) draw_sprite(spr_podcast_frank_eyes, 3, obj_podcast_frank.x, obj_podcast_frank.y);
	}
}
