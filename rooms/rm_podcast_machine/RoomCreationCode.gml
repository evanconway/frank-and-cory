podcast_maker_setup();

/*
For all instances, we assign from visually bottom to top. That's because a higher depth
appears further in the background. This we we can start at 0 for slots and reel positions.
*/

var calc_depth = 0;

// slot cover depths
with (inst_slot_1) {
	depth = calc_depth;
}
calc_depth += 2;
with (inst_slot_2) {
	depth = calc_depth;
}
calc_depth += 2;
with (inst_slot_3) {
	depth = calc_depth;
}
calc_depth += 2;
with (inst_slot_4) {
	depth = calc_depth;
}
calc_depth += 2;
with (inst_slot_5) {
	depth = calc_depth;
}
calc_depth += 2;
with (inst_slot_6) {
	depth = calc_depth;
}
calc_depth += 2;
with (inst_slot_7) {
	depth = calc_depth;
}
calc_depth += 2;
with (inst_slot_8) {
	depth = calc_depth;
}
calc_depth += 2;
with (inst_slot_9) {
	depth = calc_depth;
}
calc_depth += 2;
with (inst_slot_10) {
	depth = calc_depth;
}
calc_depth += 2;
with (inst_slot_11) {
	depth = calc_depth;
}
calc_depth += 2;
with (inst_slot_12) {
	depth = calc_depth;
}

calc_depth = 1;

// slot position depths
with (inst_483E17DC) {
	depth = calc_depth;
}
calc_depth += 2;
with (inst_39A52F5D) {
	depth = calc_depth;
}
calc_depth += 2;
with (inst_4BA96E74) {
	depth = calc_depth;
}
calc_depth += 2;
with (inst_74E55344) {
	depth = calc_depth;
}
calc_depth += 2;
with (inst_2CFDA4DC) {
	depth = calc_depth;
}
calc_depth += 2;
with (inst_3362F9A) {
	depth = calc_depth;
}
calc_depth += 2;
with (inst_7E344818) {
	depth = calc_depth;
}
calc_depth += 2;
with (inst_2ECED215) {
	depth = calc_depth;
}
calc_depth += 2;
with (inst_613DFC56) {
	depth = calc_depth;
}
calc_depth += 2;
with (inst_4848D04A) {
	depth = calc_depth;
}
calc_depth += 2;
with (inst_1C2B79B) {
	depth = calc_depth;
}
calc_depth += 2;
with (inst_79C6C881) {
	depth = calc_depth;
}

// reels
with (inst_7AAB43BD) {
	reel_id = 0;
	draggable_set_position(id, inst_79C6C881);
	x = inst_79C6C881.x;
	y = inst_79C6C881.y;
}
with (inst_586C1312) {
	reel_id = 7;
	draggable_set_position(id, inst_1C2B79B);
	x = inst_1C2B79B.x;
	y = inst_1C2B79B.y;
}
with (inst_1772A928) {
	reel_id = 2;
	draggable_set_position(id, inst_4848D04A);
	x = inst_4848D04A.x;
	y = inst_4848D04A.y;
}
with (inst_20707053) {
	reel_id = 6;
	draggable_set_position(id, inst_613DFC56);
	x = inst_613DFC56.x;
	y = inst_613DFC56.y;
}
with (inst_344345C4) {
	reel_id = 10;
	draggable_set_position(id, inst_2ECED215);
	x = inst_2ECED215.x;
	y = inst_2ECED215.y;
}
with (inst_49F5CA89) {
	reel_id = 11;
	draggable_set_position(id, inst_7E344818);
	x = inst_7E344818.x;
	y = inst_7E344818.y;
}
with (inst_C74BBA9) {
	reel_id = 9;
	draggable_set_position(id, inst_3362F9A);
	x = inst_3362F9A.x;
	y = inst_3362F9A.y;
}
with (inst_5AA3BDBA) {
	reel_id = 3;
	draggable_set_position(id, inst_2CFDA4DC);
	x = inst_2CFDA4DC.x;
	y = inst_2CFDA4DC.y;
}
with (inst_2B424FAD) {
	reel_id = 5;
	draggable_set_position(id, inst_74E55344);
	x = inst_74E55344.x;
	y = inst_74E55344.y;
}
with (inst_25994B2C) {
	reel_id = 1;
	draggable_set_position(id, inst_4BA96E74);
	x = inst_4BA96E74.x;
	y = inst_4BA96E74.y;
}
with (inst_DBB61CD) {
	reel_id = 8;
	draggable_set_position(id, inst_39A52F5D);
	x = inst_39A52F5D.x;
	y = inst_39A52F5D.y;
}
with (inst_2D775EEB) {
	reel_id = 4;
	draggable_set_position(id, inst_483E17DC);
	x = inst_483E17DC.x;
	y = inst_483E17DC.y;
}
	