class_name LevelManager;
extends CanvasLayer;

@export var player: Player;

@export_group('Layered Objects')
@export var visibility_occluder_target: Node;
@export var foreground_items_target: Node;
@export var occluded_target: Node;

func _ready() -> void:
	for object in get_tree().get_nodes_in_group("LayeredObject"):
		object.visibility_occluder_target = visibility_occluder_target;
		object.foreground_items_target = foreground_items_target;
		object.occluded_target = occluded_target;

		object.separate_layers();
