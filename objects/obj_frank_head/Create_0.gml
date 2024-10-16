event_inherited();

global.assemble_frank = dialog_get_updateable([
	frank_get_dialog_step("I feel....", FRANK_EXPRESSION.UP),
	cory_get_dialog_step("Don't feel. Just think.", CORY_EXPRESSION.BOTH_WINGS),
	cory_get_dialog_step("Tell me what we were doing before the power outage.", CORY_EXPRESSION.TAP),
	frank_get_dialog_step("Um. I'm not sure. I remember... falling?", FRANK_EXPRESSION.DOWNLEFT),
	cory_get_dialog_step("Come on, I know you've got this.", CORY_EXPRESSION.NEUTRAL),
	frank_get_dialog_step("We were...um. Oh!", FRANK_EXPRESSION.RIGHT),
	frank_get_dialog_step("Oh! Now I remember!", FRANK_EXPRESSION.BLANK),
	frank_get_dialog_step("I was taking off my head to switch out tape reels!", FRANK_EXPRESSION.HAPPY),
	cory_get_dialog_step("That's right!", CORY_EXPRESSION.BOTH_WINGS),
	
	frank_get_dialog_step("I always place my memory chip in that box, just to be safe.", FRANK_EXPRESSION.LEFT),
	frank_get_dialog_step("Whew.", FRANK_EXPRESSION.UP),
	frank_get_dialog_step("I don't know what I'd do without you, Cory.", FRANK_EXPRESSION.UP),
	
	cory_get_dialog_step("How about we put these tape reels in the story machine?", CORY_EXPRESSION.TILT),
	
	frank_get_dialog_step("Alright, well, if you don't mind giving me a hand.", FRANK_EXPRESSION.UP),
	cory_get_dialog_step("Of course I'll help.", CORY_EXPRESSION.BOTH_WINGS),
	frank_get_dialog_step("No. I mean. Literally.", FRANK_EXPRESSION.UNAMUSED),
	frank_get_dialog_step("Give me one of my arms so I can grab stuff.", FRANK_EXPRESSION.RIGHT),
	cory_get_dialog_step("How did you manage to take these off in the first place?", CORY_EXPRESSION.TAP),
]);

on_click = function() {
	if (!global.memory_cursor && !global.frank_memory_chip_added) {
		global.updateable = dialog_get_updateable([
			frank_get_dialog_step("It's me!", FRANK_EXPRESSION.HAPPY),
		]);
	} else if (!global.frank_memory_chip_added) {
		// feather ignore GM1043
		global.updateable = {
			time: 0,
			step: 0,
			steps: [
				function() {
					global.frank_memory_chip_added = true;
					global.memory_cursor = false;
					global.frank_expression = FRANK_EXPRESSION.BLANK;
					play_sfx(snd_powerup);
					step++;
				},
				function() {
					if (audio_is_playing(snd_powerup)) return;
					global.updateable = global.assemble_frank;
				},
			],
			update: function() {
				time += 1;
				steps[step]();
			},
		};
	} else if (!global.frank_attached_head) {
		global.frank_attached_head = true;
		play_sfx(snd_jude_attach_head);
		disabled = true;
		image_index = 2; // set to blank frame to avoid invisible clickable collision
		global.frank_dialog_position = FRANK_DIALOG_POSITION.ASSEMBLED_PARTLY;
		global.updateable = {
			step: 0,
			time: 0,
			steps: [
				function() {
					if (time > 60) global.updateable = dialog_get_updateable([
						frank_get_dialog_step("Yes!", FRANK_EXPRESSION.HAPPY),
						frank_get_dialog_step("Much better.", FRANK_EXPRESSION.RIGHT),
						frank_get_dialog_step("I can see the room better now.", FRANK_EXPRESSION.NEUTRAL),
					]);
				},
			],
			update: function() {
				time += 1;
				steps[step]();
			}
		};
	}
};

original_draw = draw;

draw = function () {
	if (global.frank_attached_head) return;
	if (!global.light_switch_on) image_index = 1;
	original_draw();
	frank_draw_expression();
};
