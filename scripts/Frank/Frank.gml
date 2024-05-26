global.frank_memory_chip_added = false;

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

global.frank_speaks = function() {
	// exclude chirp_0 ? sounds kinda bad...
	var sounds = [snd_frank_chirp_1, snd_frank_chirp_2, snd_frank_chirp_3, snd_frank_chirp_4];
	//audio_stop_sound(snd_frank_chirp_0);
	audio_stop_sound(snd_frank_chirp_1);
	audio_stop_sound(snd_frank_chirp_2);
	audio_stop_sound(snd_frank_chirp_3);
	audio_stop_sound(snd_frank_chirp_4);
	var snd_id = play_sfx(sounds[irandom_range(0, array_length(sounds) - 1)], 1, random_range(0.6, 1));
	audio_sound_gain(snd_id, 0, 120);
}

global.frank_get_dialog_step = function(
	text,
	expression=FRANK_EXPRESSION.NEUTRAL,
	set_position=function() {
		global.dialog_position_x = 1690;
		global.dialog_position_y = 1975;
	},
) {
	return {
		text,
		on_step: method({ expression, set_position }, function() {
			set_position();
			global.frank_expression = expression;
		}),
		on_type: global.frank_speaks,
		default_effects: "f:fnt_ally t:160,4 cp:,,420 cp:;,420 cp:.,520 cp:!,520 cp:?,520",
	}
};
