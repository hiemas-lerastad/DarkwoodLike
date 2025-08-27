class_name HumanoidPrimaryIdleAction;
extends Action;

var angle: float = 90.0;

func on_enter_action(_input: InputPackage, _context: ContextPackage) -> void:
	if entity is Player:
		angle = entity.vision_cone.angle;

func process_input_vector(input: InputPackage, context: ContextPackage, delta: float) -> void:
	var target_angle: float = (input.target_position - entity.global_position).angle();
	entity.rotation = lerp_angle(entity.rotation, target_angle,  delta * context.stats.turn_speed);

	if entity is Player:
		angle = lerp(angle, context.stats.max_aim_angle,  delta * context.stats.aim_speed);

		entity.vision_cone.angle = angle;
