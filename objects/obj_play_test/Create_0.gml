event_inherited();

column = 0;
test_position = noone;

on_click = function() {
	podcast_maker_setup();
	if (test_position == noone) {
		show_debug_message("Cannot play test audio, draggable position has not been set!");
		return;
	}
	
}
