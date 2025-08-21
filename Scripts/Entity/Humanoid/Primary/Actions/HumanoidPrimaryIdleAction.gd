class_name PlayerPrimaryIdleAction;
extends Action;

@export var turn_speed: float = 5.0;

func process_input_vector(input: InputPackage, context: ContextPackage, delta: float) -> void:
	var target_angle: float = (input.target_position - entity.global_position).angle();
	entity.rotation = lerp_angle(entity.rotation, target_angle,  delta * context.stats.turn_speed);
	#entity.rotation = target_angle;
