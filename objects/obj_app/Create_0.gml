window_set_cursor(cr_none);

global.chip_taken = false;

global.chip_cursor = false;
global.key_cursor = false;
global.memory_cursor = false;

set_tds_defaults()

start_intro();
room_goto(rm_workshop);
