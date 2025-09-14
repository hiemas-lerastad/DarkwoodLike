class_name HumanoidPrimaryAxeSwingAction;
extends Action;

var angle: float = 90.0;


func on_enter_action(_input: InputPackage, _context: ContextPackage) -> void:
	if entity is Player:
		angle = entity.vision_cone.angle;

	if entity.animation_player and entity.animation_player.has_animation('Axe Swing'):
		entity.animation_player.play('Axe Swing');


func process_input_vector(_input: InputPackage, context: ContextPackage, delta: float) -> void:
	if entity is Player:
		angle = lerp(angle, context.stats.max_aim_angle,  delta * context.stats.aim_speed);

		entity.vision_cone.angle = angle;
