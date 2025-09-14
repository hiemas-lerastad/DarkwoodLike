class_name TargetFollower;
extends Node;

@export var target: Node;
@export var follow_position: bool = false;
@export var follow_rotation: bool = false;
@export var centered: bool = false;

func _process(_delta: float) -> void:
	var offset: Vector2 = Vector2.ZERO;

	if centered and "size" in self:
		offset = self.size / 2;

	if "position" in self and follow_position and "global_position" in target:
		self.position = target.global_position - offset;

	if "rotation" in self and follow_rotation and "global_rotation" in target:
		self.rotation = target.global_rotation;
