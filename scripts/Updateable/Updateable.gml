/*
Set here so we can see reminder syntax about updateable object in the editor. 
*/
global.updateable = {
	update: function() {},
	draw: function() {},
};
global.updateable = undefined;

function updateable_start_dialog(dialog_steps_data, after_dialog_updateable=undefined) {
	var dialog_steps = is_array(dialog_steps_data) ? dialog_steps_data : [dialog_steps_data];
	if (!is_array(dialog_steps)) show_error("dialog_steps must be an array", true);
	
	// create a map of updateable objects, each which handles dialog display and interaction
	var steps = array_map(dialog_steps, function(step) {
		if (!is_string(step) && !is_struct(step)) show_error("dialog_steps each array value must be string or dialog struct", true);
		var tds_instance = new TagDecoratedTextDefault(is_string(step) ? step : step.text, "f:fnt_ally t:80,2");
		tag_decorated_text_reset_typing(tds_instance);
		
		tag_decorated_text_set_on_type_callback(tds_instance, function() {
			play_sfx(snd_type, 1, random_range(0.9, 1.1))
		});
		
		var on_step = is_string(step) ? function() {} : step.on_step;
		
		// this must be an updateable with an update() and draw()
		return {
			tds_instance: tds_instance,
			on_step: on_step,
			next_updateable: undefined,
			update: function() {
				var clicked = mouse_check_button_pressed(mb_any);
				if (tag_decorated_text_get_typing_finished(tds_instance) && clicked) {
					global.updateable = next_updateable;
					return
				}
				if (clicked) tag_decorated_text_advance(tds_instance);
				on_step();
			},
			draw: function() {
				draw_set_alpha(1); // why do we need this??
				tag_decorated_text_draw(tds_instance, 0, 0);
			},
		};
	});
	
	// map each step to the next step when finished
	for (var i = 0; i < array_length(steps) - 1; i++) {
		steps[i].next_updateable = steps[i + 1];
	}
	
	steps[array_length(steps) - 1].next_updateable = after_dialog_updateable;
	
	// set updateable to first dialog step
	global.updateable = steps[0];
}