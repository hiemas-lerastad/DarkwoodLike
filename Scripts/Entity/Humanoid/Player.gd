class_name Player;
extends Entity;

var vision_cone: VisionCone;


func _enter_tree() -> void:
	GLOBALS.player = self;


func update_vision_cone(new_angle: float) -> void:
	vision_cone.angle = new_angle;


func on_attack_collision(body: Node) -> void:
	if body is Entity:
		var entity: Entity = body as Entity;

		entity.context_gatherer.stats.health -= 2.0;
