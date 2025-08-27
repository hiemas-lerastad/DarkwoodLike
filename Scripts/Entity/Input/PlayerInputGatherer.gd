class_name PlayerInputGatherer;
extends InputGatherer;

@export var toggle_sprint: bool = false;

var mouse_event: InputEvent;

var sprinting: bool = false;

func _unhandled_input(event: InputEvent) -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_CONFINED:
		if event is InputEventMouseMotion:
				mouse_event = event;

func gather_input() -> InputPackage:
	var new_input: InputPackage = InputPackage.new();

	# Basic Movement
	new_input.actions.append("idle");

	new_input.input_direction = Input.get_vector("movement_left", "movement_right", "movement_forward", "movement_backward");

	if new_input.input_direction != Vector2.ZERO:
		new_input.actions.append("jog");

	# Sprint
	if toggle_sprint:
		if Input.is_action_just_pressed("movement_sprint"):
			sprinting = !sprinting;
	elif Input.is_action_pressed("movement_sprint"):
		sprinting = true;
	else:
		sprinting = false;

	if sprinting:
		new_input.actions.append("sprint");

	# Mouse Events
	#if Input.is_action_just_pressed("interact_click"):
		#new_input.actions.append("interact_primary");
	
	if Input.is_action_pressed("interact_secondary"):
		new_input.actions.append("aim");

	new_input.target_position = entity.get_global_mouse_position();

	if mouse_event:
		new_input.pivot_event = mouse_event.relative;
		mouse_event = null;

	return new_input;
