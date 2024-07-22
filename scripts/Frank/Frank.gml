enum FRANK_EXPRESSION {
	BLANK,
	NEUTRAL,
	HAPPY,
	RIGHT,
	UP,
	UNAMUSED,
	DOWNLEFT,
	LEFT
}

global.frank_expression = FRANK_EXPRESSION.BLANK;

global.frank_sounds = [
	snd_frank_chirp_1,
	snd_frank_chirp_2,
	snd_frank_chirp_3,
	snd_frank_chirp_4,
];

global.frank_speaks = function() {
	var sounds = global.frank_sounds;
	
	for (var i = 0; i < array_length(sounds); i++) {
		audio_stop_sound(sounds[i]);
	}

	var snd_id = play_sfx(sounds[irandom_range(0, array_length(sounds) - 1)], 1, random_range(0.6, 1));
	audio_sound_gain(snd_id, 0, 120);
}

enum FRANK_DIALOG_POSITION {
	INTRO_HEAD,
}

global.frank_dialog_position = FRANK_DIALOG_POSITION.INTRO_HEAD;

function frank_get_dialog_step(text, expression=FRANK_EXPRESSION.NEUTRAL) {
	return {
		text,
		on_step: method({ expression }, function() {
			if (global.frank_dialog_position == FRANK_DIALOG_POSITION.INTRO_HEAD) {
				global.dialog_position_x = 1690;
				global.dialog_position_y = 1975;
			}
			global.frank_expression = expression;
		}),
		on_type: global.frank_speaks,
		default_effects: "f:fnt_ally t:160,4 cp:,,420 cp:;,420 cp:.,520 cp:!,520 cp:?,520",
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
global.frank_idle_expression = FRANK_EXPRESSION.NEUTRAL;
global.frank_idle_expression_time = 80;

function frank_draw_expression(x_left=271, y_left=166, x_right=271, y_right=166) {
	if (global.updateable == undefined) {
		global.frank_idle_expression_time -= 1;
		if (global.frank_idle_expression_time < 0) {
			global.frank_idle_expression_time = irandom_range(80, 140);
			var options = array_filter(global.frank_idle_expression_options, function(option) {
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
}
