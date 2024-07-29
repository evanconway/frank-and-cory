enum CORY_EXPRESSION {
	NEUTRAL,
	TAP,
	SALUTE,
	BOTH_WINGS,
	TILT,
}

global.cory_expression = FRANK_EXPRESSION.BLANK;

global.cory_set_dialog_position = function() {
	global.dialog_position_x = 3100;
	global.dialog_position_y = 505;
};
	
global.cory_set_dialog_position_head = function() {
	global.dialog_position_x = 1270;
	global.dialog_position_y = 1080;
};

enum CORY_DIALOG_POSITION {
	INTRO_BREAKER,
	INTRO_HEAD,
}

global.cory_dialog_position = CORY_DIALOG_POSITION.INTRO_BREAKER;

global.cory_sounds = [
	snd_jude_cory_chirp_1,
	snd_jude_cory_chirp_2,
	snd_jude_cory_chirp_3,
	snd_jude_cory_chirp_4,
	snd_jude_cory_chirp_5,
	snd_jude_cory_chirp_6,
	snd_jude_cory_chirp_7,
	snd_jude_cory_chirp_8,
];

global.cory_speaks = function() {
	var sounds = global.cory_sounds;
	
	for (var i = 0; i < array_length(sounds); i++) {
		audio_stop_sound(sounds[i]);
	}

	var snd_id = play_sfx(sounds[irandom_range(0, array_length(sounds) - 1)], 0.7, random_range(1.2, 1.5));
	audio_sound_gain(snd_id, 0, 60);
}

function cory_get_dialog_step(text, expression=CORY_EXPRESSION.NEUTRAL) {	
	return {
		text,
		width: 800,
		on_step: method({ expression }, function() {
			if (global.cory_dialog_position == CORY_DIALOG_POSITION.INTRO_BREAKER) {
				global.dialog_position_x = 3546;
				global.dialog_position_y = 346;
			}
			if (global.cory_dialog_position == CORY_DIALOG_POSITION.INTRO_HEAD) {
				global.dialog_position_x = 2116;
				global.dialog_position_y = 1323;
			}
			global.cory_expression = expression; // we don't have cory expressions yet
		}),
		on_type: global.cory_speaks,
		default_effects: "black f:fnt_ally t:100,2.5 cp:,,420 cp:;,420 cp:.,520 cp:!,520 cp:?,520",
		pre_dialog_draw: function() {
			var word_balloon = undefined;
			if (global.cory_dialog_position == CORY_DIALOG_POSITION.INTRO_BREAKER) word_balloon = spr_word_balloon_cory_right;
			if (global.cory_dialog_position == CORY_DIALOG_POSITION.INTRO_HEAD) word_balloon = spr_word_balloon_cory_left;
			if (word_balloon != undefined) draw_sprite(word_balloon, 0, global.dialog_position_x, global.dialog_position_y);
		}
	}
};

function cory_set_expression() {
	if (global.updateable == undefined) {
		global.cory_expression = CORY_EXPRESSION.NEUTRAL;
	}
	if (!instance_exists(obj_workshop_cory)) return;
	if (global.cory_expression == CORY_EXPRESSION.NEUTRAL) obj_workshop_cory.image_index = 0;
	if (global.cory_expression == CORY_EXPRESSION.TAP) obj_workshop_cory.image_index = 1;
	if (global.cory_expression == CORY_EXPRESSION.SALUTE) obj_workshop_cory.image_index = 2;
	if (global.cory_expression == CORY_EXPRESSION.BOTH_WINGS) obj_workshop_cory.image_index = 3;
	if (global.cory_expression == CORY_EXPRESSION.TILT) obj_workshop_cory.image_index = 4;
}
