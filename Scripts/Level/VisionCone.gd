class_name VisionCone;
extends Node2D;

@export var left_occluder: LightOccluder2D;
@export var right_occluder: LightOccluder2D;

@export var angle: float = 90.0:
	set(value):
		angle = value;
		output_angle = (angle - 90.0) / 2;

var output_angle: float;


func _physics_process(_delta: float) -> void:
	left_occluder.rotation_degrees = -output_angle;
	right_occluder.rotation_degrees = output_angle;
