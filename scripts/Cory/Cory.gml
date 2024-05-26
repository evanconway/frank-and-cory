enum CORY_EXPRESSION {
	BLANK,
	NEUTRAL,
	HAPPY,
	RIGHT,
	UP,
	UNAMUSED,
	DOWNLEFT,
	LEFT
}

global.cory_set_dialog_position = function() {
	global.dialog_position_x = 3100;
	global.dialog_position_y = 505;
};
	
global.cory_set_dialog_position_head = function() {
	global.dialog_position_x = 1270;
	global.dialog_position_y = 1080;
};

global.cory_get_dialog_step = function(
	text,
	expression=CORY_EXPRESSION.NEUTRAL,
	set_position=function() {
		global.dialog_position_x = 3100;
		global.dialog_position_y = 505;
	},
) {
	return {
		text,
		on_step: method({ expression, set_position }, function() {
			set_position();
			// global.cory_expression = expression; // we don't have cory expressions yet
		}),
		default_effects: "f:fnt_ally t:80,2 cp:,,420 cp:;,420 cp:.,520 cp:!,520 cp:?,520",
	}
};
