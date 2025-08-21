class_name HumanoidMovementIdleAction;
extends Action;

@export var air_resistance: float = 0.01;

func process_input_vector(_input: InputPackage, context: ContextPackage, _delta: float) -> void:
	if context.states.has("ground"):
		entity.velocity.x = move_toward(entity.velocity.x, 0, context.stats.move_speed);
		entity.velocity.y = move_toward(entity.velocity.y, 0, context.stats.move_speed);
	else:
		entity.velocity.x = move_toward(entity.velocity.x, 0, air_resistance);
		entity.velocity.y = move_toward(entity.velocity.y, 0, air_resistance);
