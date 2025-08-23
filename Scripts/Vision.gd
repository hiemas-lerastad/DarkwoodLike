class_name Vision;
extends Node2D;

@export var player: Player;

func _process(_delta: float) -> void:
	position = player.global_position;
	rotation = player.global_rotation;
