event_inherited();

clicks = 0;

attempt_solve = function() {
	clicks = clamp(clicks + 1, 0, 2);
	if (clicks >= 2 && !global.frank_memory_chip_added) clicks = 0;
	if (clicks >= 2) disabled = true;
};

// feather ignore GM1043
shake = {
	attempt_solve,
	offsets: { x: 0, y: 0 },
	randomize_offsets: function() {
		offsets.x = irandom_range(-10, 10);
		offsets.y = irandom_range(-10, 10);
	},
	shakes: 0,
	time: 0,
	step: 0,
	steps: [
		function() {
			if (time >= 8) {
				time = 0;
				if (shakes < 6) {
					shakes += 1;
					randomize_offsets();
				} else {
					step += 1;
					offsets.x = 0;
					offsets.y = 0;
					attempt_solve();
					time = 0;
				}
			}
			obj_puzzle_cube.x = offsets.x;
			obj_puzzle_cube.y = offsets.y;
		},
		function() {
			if (time >= 50) {
				if (obj_puzzle_cube.clicks == 0) {
					global.updateable = dialog_get_updateable([
						frank_get_dialog_step("Ugh...", FRANK_EXPRESSION.UNAMUSED),
						frank_get_dialog_step("I don't remember how to solve this.", FRANK_EXPRESSION.UP),
					]);
				} else if (obj_puzzle_cube.clicks == 2) {
					global.updateable = dialog_get_updateable([
						cory_get_dialog_step("You solved it!", CORY_EXPRESSION.BOTH_WINGS),
						cory_get_dialog_step("I knew you had it in you.", CORY_EXPRESSION.SALUTE),
						frank_get_dialog_step("I just needed the old memory boost.", FRANK_EXPRESSION.HAPPY),
						frank_get_dialog_step("Er... memory chip.", FRANK_EXPRESSION.DOWNLEFT),
					]);
				} else {
					global.updateable = undefined;
				}
			}
		},
	],
	update: function() {
		time += 1;
		steps[step]();
	},
};

on_click = function() {
	play_sfx(snd_puzzle_cube);
	shake.randomize_offsets();
	shake.time = 0;
	shake.shakes = 0;
	shake.step = 0;
	global.updateable = shake;
};

draw = function() {
	image_index = clicks;
	draw_self();
};
