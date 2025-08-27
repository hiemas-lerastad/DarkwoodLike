class_name PlayerFollower;
extends Node2D;

var player: Player;

@export var follow_position: bool = false;
@export var follow_rotation: bool = false;

func _process(_delta: float) -> void:
	if not player:
		player = GLOBALS.player;
	
	if follow_position:
		position = player.global_position;

	if follow_rotation:
		rotation = player.global_rotation;
