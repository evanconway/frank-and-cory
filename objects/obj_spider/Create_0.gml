event_inherited();

original_draw = draw;
draw = function() {
	image_index = global.spider_pose;
	original_draw();
}
