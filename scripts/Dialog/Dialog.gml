global.dialog_position_x = 0;
global.dialog_position_y = 0;
global.click_to_continue_message = undefined;
global.click_to_continue_count = 0;
global.click_to_continue_alpha = 0;

/**
 * Get updateable instance that is linked to other updateable instance which create a dialog sequence.
 */
function dialog_get_updateable(
	dialog_steps_data,
	options = {
		after_dialog_updateable: undefined,
		pre_dialog_draw: function() {},
		on_step_all: function() {},
		word_balloon: undefined,
	}
) {
	if (global.click_to_continue_message == undefined) global.click_to_continue_message = new TagDecoratedTextDefault("Click to continue...", "f:fnt_ally");
	
	var after_dialog_updateable = variable_struct_exists(options, "after_dialog_updateable") ? options.after_dialog_updateable : undefined;
	var pre_dialog_draw = variable_struct_exists(options, "pre_dialog_draw") ? options.pre_dialog_draw : function() {};
	var on_step_all = variable_struct_exists(options, "on_step_all") ? options.on_step_all : function() {};
	var word_balloon = variable_struct_exists(options, "word_balloon") ? options.word_balloon : undefined;
	
	var dialog_steps = is_array(dialog_steps_data) ? dialog_steps_data : [dialog_steps_data];
	if (!is_array(dialog_steps)) show_error("dialog_steps must be an array", true);
	
	// create a map of updateable objects, each which handles dialog display and interaction
	var steps = array_map(dialog_steps, method({ on_step_all, pre_dialog_draw, word_balloon }, function(step) {
		if (!is_string(step) && !is_struct(step)) show_error("dialog_steps each array value must be string or dialog struct", true);
		
		var default_effects = (is_struct(step) && variable_struct_exists(step, "default_effects")) ? step.default_effects : "f:fnt_ally t:80,2";
		
		var tds_instance = new TagDecoratedTextDefault(is_string(step) ? step : step.text, default_effects, 1000);
		
		tag_decorated_text_reset_typing(tds_instance);
		var on_type = (is_struct(step) && variable_struct_exists(step, "on_type")) ? step.on_type : function() {
			play_sfx(snd_type, 1, random_range(0.9, 1.1));
		};
		
		tag_decorated_text_set_on_type_callback(tds_instance, on_type);
		var on_step = (is_struct(step) && variable_struct_exists(step, "on_step")) ? step.on_step : function() {};
		
		// this must be an updateable with an update() and draw()
		var result = {
			tds_instance,
			on_step,
			on_step_all,
			pre_dialog_draw,
			word_balloon,
			next_updateable: undefined,
			update: function() {
				on_step_all();
				on_step();
				var clicked = mouse_check_button_pressed(mb_any);
				if (tag_decorated_text_get_typing_finished(tds_instance) && clicked) {
					global.updateable = next_updateable;
					return
				}
				if (clicked) tag_decorated_text_advance(tds_instance);
			},
			draw: function() {
				draw_set_alpha(1); // why do we need this??
				pre_dialog_draw();
				if (word_balloon != undefined) {
					draw_sprite(word_balloon, 0, global.dialog_position_x, global.dialog_position_y);
				}
				draw_set_halign(fa_center);
				draw_set_valign(fa_middle);
				tag_decorated_text_draw(tds_instance, global.dialog_position_x, global.dialog_position_y);
				// reset to force dialog to always set position
				global.dialog_position_x = 0;
				global.dialog_position_y = 0;
				
				// continue message
				if (tag_decorated_text_get_typing_finished(tds_instance)) {
					global.click_to_continue_count -= 1;
					if (global.click_to_continue_count <= 0) {
						draw_set_halign(fa_left);
						draw_set_valign(fa_bottom);
						global.click_to_continue_alpha = clamp(global.click_to_continue_alpha + 0.008, 0, 0.4);
						draw_set_alpha(global.click_to_continue_alpha);
						tag_decorated_text_draw(global.click_to_continue_message, 0, display_get_gui_height());
					}
				} else {
					global.click_to_continue_count = 240;
					global.click_to_continue_alpha = 0;
				}
				
				draw_set_halign(fa_left);
				draw_set_valign(fa_top);
			},
		};
		
		return result;
	}));
	
	// map each step to the next step when finished
	for (var i = 0; i < array_length(steps) - 1; i++) {
		steps[i].next_updateable = steps[i + 1];
	}
	steps[array_length(steps) - 1].next_updateable = after_dialog_updateable;
	return steps[0];
}
