podcast_maker_setup();

/*
For all instances, we assign from visually bottom to top. That's because a higher depth
appears further in the background. This we we can start at 0 for slots and reel positions.
*/

var anchor_depth = inst_483E17DC.depth;

var calc_depth = anchor_depth;

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

calc_depth = anchor_depth + 1;

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

var set_reel_data = function(reel=noone, reel_new_id=0, position=noone) {
	with (reel) {
		reel_id = reel_new_id;
		draggable_set_position(id, position);
		x = position.x;
		y = position.y;
		depth = position.depth;
	}
};

// reels
set_reel_data(inst_7AAB43BD, 0, inst_79C6C881)
set_reel_data(inst_586C1312, 7, inst_1C2B79B)
set_reel_data(inst_1772A928, 2, inst_4848D04A)
set_reel_data(inst_20707053, 6, inst_613DFC56)
set_reel_data(inst_344345C4, 10, inst_2ECED215)
set_reel_data(inst_49F5CA89, 11, inst_7E344818)
set_reel_data(inst_C74BBA9, 9, inst_3362F9A)
set_reel_data(inst_5AA3BDBA, 2, inst_2CFDA4DC)
set_reel_data(inst_2B424FAD, 5, inst_74E55344)
set_reel_data(inst_25994B2C, 1, inst_4BA96E74)
set_reel_data(inst_DBB61CD, 8, inst_39A52F5D)
set_reel_data(inst_2D775EEB, 4, inst_483E17DC)

	