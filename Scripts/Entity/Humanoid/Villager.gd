class_name Villager;
extends Entity;


@export var look_target: Node2D:
	set(value):
		look_target = value;
		if input_gatherer:
			input_gatherer.look_target = value;


@export var move_target: Node2D:
	set(value):
		move_target = value;
		if input_gatherer:
			input_gatherer.move_target = value;


func _ready() -> void:
	input_gatherer.look_target = look_target;
	input_gatherer.move_target = move_target;
