// draw_set_color(make_color_rgb(47, 43, 50));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_ally_title);

font_enable_effects(fnt_ally_title, true, {
	outlineColour: make_color_rgb(47, 43, 50),
	coreColour: c_white,
	// coreColour: make_color_rgb(47, 43, 50),
	coreAlpha: 1,
	outlineEnable: true,
    outlineDistance: 30,
    // outlineColour: c_yellow
});

draw_text_ext_transformed(display_get_gui_width()/2, display_get_gui_height()/2 - 140, "Frank and Cory Make a Story", 250, 1500, 1.4, 1.4, 0);
