class_name Visibility;
extends SubViewportContainer;

@export var target: Node;
@export var statics: Node;

var base_position: Vector2;


func _ready() -> void:
	base_position = global_position;


func _process(_delta: float) -> void:
	if "global_position" in target:
		global_position = target.global_position - size / 2;


	if "global_position" in statics:
		statics.global_position = -global_position;
