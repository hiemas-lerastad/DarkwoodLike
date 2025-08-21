class_name HumanoidMovementJogAction;
extends Action;

func process_input_vector(input: InputPackage, context: ContextPackage, _delta: float) -> void:
	if context.states.has("ground"):
		var direction: Vector2 = input.input_direction.normalized();
		entity.velocity.x = direction.x * context.stats.move_speed;
		entity.velocity.y = direction.y * context.stats.move_speed;
