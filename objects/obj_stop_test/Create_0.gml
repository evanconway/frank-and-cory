event_inherited();

on_click = podcast_stop_test;

pre_update = function() {
	disabled = global.updateable != global.podcast_test_player;
};
