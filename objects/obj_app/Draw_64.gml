if (global.updateable != undefined) {
	// use different reference so we can change global.updateable in update or draw
	var updateable = global.updateable;
	updateable.update();
	clickables_draw();
	updateable.draw();
} else {
	clickables_update();
	clickables_draw();
}
