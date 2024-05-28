event_inherited();

original_draw = draw;

draw = function() {
	visible = !global.frank_memory_chip_added;
	original_draw();
};

global.assemble_frank = dialog_get_updateable([
	global.frank_get_dialog_step("I feel....", FRANK_EXPRESSION.UP),
	global.cory_get_dialog_step("Don't feel. Just think. Tell me what we were doing before the power outage.", CORY_EXPRESSION.NEUTRAL),
	global.frank_get_dialog_step("Um. I'm not sure. I remember...falling?", FRANK_EXPRESSION.DOWNLEFT),
	global.cory_get_dialog_step("Come on, I know you got this.", CORY_EXPRESSION.NEUTRAL),
	global.frank_get_dialog_step("We were...um. Oh!", FRANK_EXPRESSION.RIGHT),
	global.frank_get_dialog_step("Oh! Now I remember!", FRANK_EXPRESSION.BLANK),
	global.frank_get_dialog_step("I was taking off my head to switch out tape reels!", FRANK_EXPRESSION.HAPPY),
	global.cory_get_dialog_step("That's right!", CORY_EXPRESSION.NEUTRAL),
	global.frank_get_dialog_step("I must have dropped my head when the lights went out.", FRANK_EXPRESSION.LEFT),
	global.frank_get_dialog_step("Which explains how the memory chip became dislodged.", FRANK_EXPRESSION.UNAMUSED),
	global.cory_get_dialog_step("Now you're starting to sound like Frank again.", CORY_EXPRESSION.NEUTRAL),
	global.frank_get_dialog_step("Whew. I don't know what I'd do without you, Cory.", FRANK_EXPRESSION.UP),
	global.cory_get_dialog_step("How about we finish cutting this story together and get some fresh air?", CORY_EXPRESSION.NEUTRAL),
	global.frank_get_dialog_step("Like a picnic?", FRANK_EXPRESSION.NEUTRAL),
	global.cory_get_dialog_step("Sure, whatever. I just wanna get out of this studio.", CORY_EXPRESSION.NEUTRAL),
	global.frank_get_dialog_step("Alright, well, if you don't mind giving me a hand.", FRANK_EXPRESSION.UP),
	global.cory_get_dialog_step("Of course I'll help.", CORY_EXPRESSION.NEUTRAL),
	global.frank_get_dialog_step("No. I mean. Literally.", FRANK_EXPRESSION.UNAMUSED),
	global.frank_get_dialog_step("Give me one of my arms so I can grab stuff.", FRANK_EXPRESSION.RIGHT),
	global.cory_get_dialog_step("How did you even manage to take these off in the first place?", CORY_EXPRESSION.NEUTRAL),
	global.frank_get_dialog_step("Just hurry up.", FRANK_EXPRESSION.DOWNLEFT),
]);

on_click = function() {
	disabled = true;
	global.updateable = dialog_get_updateable([
		global.frank_get_dialog_step("That looks familiar!", FRANK_EXPRESSION.RIGHT),
		global.cory_get_dialog_step("I agree.", CORY_EXPRESSION.NEUTRAL),
		global.cory_get_dialog_step("Let's fix you up!", CORY_EXPRESSION.NEUTRAL),
	], {
		after_dialog_updateable: {
			time: 0,
			step: 0,
			steps: [
				function() {
					global.frank_memory_chip_added = true;
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
};
