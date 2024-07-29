event_inherited();

global.assemble_frank = dialog_get_updateable([
	frank_get_dialog_step("I feel....", FRANK_EXPRESSION.UP),
	cory_get_dialog_step("Don't feel. Just think.", CORY_EXPRESSION.BOTH_WINGS),
	cory_get_dialog_step("Tell me what we were doing before the power outage.", CORY_EXPRESSION.TAP),
	frank_get_dialog_step("Um. I'm not sure. I remember...falling?", FRANK_EXPRESSION.DOWNLEFT),
	cory_get_dialog_step("Come on, I know you got this.", CORY_EXPRESSION.NEUTRAL),
	frank_get_dialog_step("We were...um. Oh!", FRANK_EXPRESSION.RIGHT),
	frank_get_dialog_step("Oh! Now I remember!", FRANK_EXPRESSION.BLANK),
	frank_get_dialog_step("I was taking off my head to switch out tape reels!", FRANK_EXPRESSION.HAPPY),
	cory_get_dialog_step("That's right!", CORY_EXPRESSION.BOTH_WINGS),
	frank_get_dialog_step("I must have dropped my head when the lights went out.", FRANK_EXPRESSION.LEFT),
	frank_get_dialog_step("Which explains how the memory chip became dislodged.", FRANK_EXPRESSION.UNAMUSED),
	cory_get_dialog_step("Now you're starting to sound like Frank again.", CORY_EXPRESSION.SALUTE),
	frank_get_dialog_step("Whew. I don't know what I'd do without you, Cory.", FRANK_EXPRESSION.UP),
	cory_get_dialog_step("How about we finish cutting this story together and get some fresh air?", CORY_EXPRESSION.NEUTRAL),
	frank_get_dialog_step("Like a picnic?", FRANK_EXPRESSION.NEUTRAL),
	cory_get_dialog_step("Sure, whatever. I just wanna get out of this studio.", CORY_EXPRESSION.TILT),
	frank_get_dialog_step("Alright, well, if you don't mind giving me a hand.", FRANK_EXPRESSION.UP),
	cory_get_dialog_step("Of course I'll help.", CORY_EXPRESSION.BOTH_WINGS),
	frank_get_dialog_step("No. I mean. Literally.", FRANK_EXPRESSION.UNAMUSED),
	frank_get_dialog_step("Give me one of my arms so I can grab stuff.", FRANK_EXPRESSION.RIGHT),
	cory_get_dialog_step("How did you even manage to take these off in the first place?", CORY_EXPRESSION.TAP),
	frank_get_dialog_step("Just hurry up.", FRANK_EXPRESSION.DOWNLEFT),
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
		/*
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("Alright.", CORY_EXPRESSION.TILT),
			cory_get_dialog_step("I hope this works.", CORY_EXPRESSION.TAP),
			frank_get_dialog_step("I'm ready.", FRANK_EXPRESSION.RIGHT),
			frank_get_dialog_step("Hit it!", FRANK_EXPRESSION.UP),
		], {
			after_dialog_updateable: {
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
			},
		});
		*/
	} else if (!global.frank_attached_head) {
		global.frank_attached_head = true;
		play_sfx(snd_button);
		disabled = true;
		global.updateable = {
			step: 0,
			time: 0,
			steps: [
				function() {
					if (time > 60) global.updateable = dialog_get_updateable([
						frank_get_dialog_step("Yes", FRANK_EXPRESSION.HAPPY),
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
	if (!global.light_switch_on) image_index = 1; // pointless until we add back head lighting
	original_draw();
	frank_draw_expression();
};
