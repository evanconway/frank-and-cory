/*
Set here so we can see reminder syntax about updateable object in the editor. 
*/
global.updateable = {
	update: function() {},
	draw: function() {},
};
global.updateable = undefined;

function updateable_start_dialog(dialog_steps) {
	if (!is_array(dialog_steps)) show_error("dialog_steps must be an array", true);
	
	// create a map of updateable objects, each which handles dialog display and interaction
	var steps = array_map(dialog_steps, function(step) {
		if (!is_string(step) && !is_struct(step)) show_error("dialog_steps each array value must be string or dialog struct", true);
		var tds_instance = new TagDecoratedTextDefault(is_string(step) ? step : step.text);
		tag_decorated_text_reset_typing(tds_instance);
		var on_step = is_struct(step) ? function() {} : step.on_step;
		
		/*
		"b" for binding struct, only used to bind the above values to the functions below.
		See https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Variable_Functions/method.htm
		for details on method() and why we need to use it here.
		*/
		var b = {
			tds_instance: tds_instance,
			on_step: on_step,
		};
		
		// this must be an updateable with an update() and draw()
		return {
			next_updateable: undefined,
			update: method(b, function() {
				if (tag_decorated_text_get_typing_finished(tds_instance)) {
					global.updateable = next_updateable;
				}
				if (mouse_check_button_pressed(mb_any)) tag_decorated_text_advance(tds_instance);
				on_step();
			}),
			draw: method(b, function() {
				tag_decorated_text_draw(tds_instance, 0, 0);
			}),
		};
	});
	
	// map each step to the next step when finished
	for (var i = 0; i < array_length(steps) - 1; i++) {
		steps[i].next_updateable = steps[i + 1];
	}
	
	// set updateable to first dialog step
	global.updateable = steps[0];
}