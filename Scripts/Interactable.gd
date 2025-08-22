class_name Interactable;
extends Node2D;

signal interacted;
signal can_interact;

@export var area: Area2D;

@export var player: Player;
@export var max_range: float;
@export var trigger: String;

var hovered: bool = false;
var interacted_emitted: bool = false; 
var interactable: bool = true;


func _on_mouse_entered() -> void:
	hovered = true;


func _on_mouse_exited() -> void:
	hovered = false;


func _physics_process(_delta: float) -> void:
	if player:
		if hovered and global_position.distance_to(player.global_position) < max_range and not interactable:
			can_interact.emit(self, true);

		if interactable and (global_position.distance_to(player.global_position) > max_range or not hovered):
			can_interact.emit(self, false);

		if interactable and Input.is_action_just_pressed(trigger):
			interacted.emit(self);


func on_interact() -> void:
	pass;
