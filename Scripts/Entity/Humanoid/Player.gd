class_name Player;
extends Entity;


func _enter_tree() -> void:
	GLOBALS.player = self;
