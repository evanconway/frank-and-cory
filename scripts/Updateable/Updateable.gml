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
		if (is_string(step)) return {
			tds_instance: new TagDecoratedTextDefault(step),
			on_step: function() {
				// do nothing
			},
		};
		return {
			tds_instance: new TagDecoratedTextDefault(is_string(step) ? step : step.text),
			on_step: (is_struct(step) && variable_struct_exists(step, "on_step"))
		};
	});
	
	// map each step to the next step when finished
	// ensure final step clears global.updateable
	
	// set updateable to first dialog step
}