event_inherited();

on_click = podcast_machine_stop_all;

pre_update = function() {
	disabled = global.updateable != global.podcast_test_player;
};
