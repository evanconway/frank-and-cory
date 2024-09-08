event_inherited();

on_click = function() {
	if (image_index == 2) return;
	image_index += 1;
	if (image_index == 2) disabled = true;
	play_sfx(snd_puzzle_cube);
	global.updateable = {
		time: 0,
		update: function() {
			time += 1;
			if (time >= 90) global.updateable = undefined;
		}
	};
};

draw = function() {
	draw_self();
};
