class_name PlayerFollower;
extends Node2D;

var player: Player;

func _process(_delta: float) -> void:
	if not player:
		player = GLOBALS.player;

	position = player.global_position;
	rotation = player.global_rotation;
