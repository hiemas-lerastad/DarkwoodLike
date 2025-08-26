class_name Canopy;
extends Node2D;

@export var height: float = 1.0;
@export var max_distance: float = 500.0;

var target: Node2D;
var base_position: Vector2;

func _ready() -> void:
	base_position = global_position;

	if !target and GLOBALS.camera:
		target = GLOBALS.camera;


func _physics_process(_delta: float) -> void:
	var direction: Vector2 = base_position.direction_to(target.global_position);
	var distance: float = base_position.distance_to(target.global_position);
	distance = clamp(distance, 0.0, max_distance);

	global_position = base_position - ((direction * distance) * (height / 10));
