class_name UIInputGatherer;
extends InputGatherer;

var trigger_container: bool = false;

func gather_input() -> InputPackage:
	var new_input: InputPackage = InputPackage.new();

	if Input.is_action_just_pressed("ui_action_toggle"):
		new_input.actions.append("toggle");

	if Input.is_action_just_pressed("ui_action_inventory"):
		new_input.actions.append("inventory");

	if trigger_container:
		new_input.actions.append("container");
		trigger_container = false;

	return new_input;
