class_name VillagerInputGatherer;
extends InputGatherer;

@export var toggle_sprint: bool = false;
@export var look_target: Node2D;
@export var move_target: Node2D;
@export var navigation_agent: NavigationAgent2D;

var mouse_event: InputEvent;

var sprinting: bool = false;

func gather_input() -> InputPackage:
	var new_input: InputPackage = InputPackage.new();

	# Basic Movement
	new_input.actions.append("idle");

	#new_input.input_direction = Input.get_vector("movement_left", "movement_right", "movement_forward", "movement_backward");

	if new_input.input_direction != Vector2.ZERO:
		new_input.actions.append("jog");

	# Sprint
	#if toggle_sprint:
		#if Input.is_action_just_pressed("movement_sprint"):
			#sprinting = !sprinting;
	#elif Input.is_action_pressed("movement_sprint"):
		#sprinting = true;
	#else:
		#sprinting = false;
#
	#if sprinting:
		#new_input.actions.append("sprint");

	if move_target:
		navigation_agent.target_position = move_target.global_position;
		new_input.target_position = navigation_agent.get_next_path_position();
		new_input.input_direction = entity.global_position.direction_to(navigation_agent.get_next_path_position());

	if look_target:
		var ray_params: PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.new();
		ray_params.from = entity.global_position;
		ray_params.to =  look_target.global_position;
		ray_params.collision_mask = 1;

		var space_rid: RID = entity.get_world_2d().space;
		var space_state: PhysicsDirectSpaceState2D = PhysicsServer2D.space_get_direct_state(space_rid);
		var ray_result: Dictionary = space_state.intersect_ray(ray_params);

		if ray_result.is_empty():
			new_input.target_position = look_target.global_position;
	else:
		new_input.target_position = entity.global_position

	if mouse_event:
		new_input.pivot_event = mouse_event.relative;
		mouse_event = null;

	return new_input;
