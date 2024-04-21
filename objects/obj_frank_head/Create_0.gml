event_inherited();

on_click = function() {
	global.updateable = dialog_get_updateable([
		"Wow you just clicked on my head!",
		"Hopefully now you see dialog.",
		"This should help us setup the rest of the game.",
	]);
};
