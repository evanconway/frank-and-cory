enum CORY_EXPRESSION {
	NEUTRAL,
	TAP,
	SALUTE,
	BOTH_WINGS,
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

function cory_get_dialog_step(text, expression=CORY_EXPRESSION.NEUTRAL) {
	return {
		text,
		on_step: method({ expression }, function() {
			if (global.cory_dialog_position == CORY_DIALOG_POSITION.INTRO_BREAKER) {
				global.dialog_position_x = 3100;
				global.dialog_position_y = 505;
			}
			if (global.cory_dialog_position == CORY_DIALOG_POSITION.INTRO_HEAD) {
				global.dialog_position_x = 1270;
				global.dialog_position_y = 1080;
			}
			global.cory_expression = expression; // we don't have cory expressions yet
		}),
		default_effects: "f:fnt_ally t:80,2 cp:,,420 cp:;,420 cp:.,520 cp:!,520 cp:?,520",
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
}
