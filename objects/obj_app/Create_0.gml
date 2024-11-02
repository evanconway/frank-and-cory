global.frame_time = game_get_speed(gamespeed_microseconds);

window_set_cursor(cr_none);

global.chip_taken = false;

global.chip_cursor = false;
global.key_cursor = false;
global.memory_cursor = false;

set_tds_defaults()

//reset_game();

room_goto(rm_cover_art);