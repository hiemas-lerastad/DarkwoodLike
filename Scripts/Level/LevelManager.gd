class_name LevelManager;
extends CanvasLayer;

@export var player: Player;
@export var vision_cone: VisionCone;
@export var player_followers: Array[Node];

@export_group('Layered Objects')
@export var background_items_target: Node;
@export var visibility_occluder_target: Node;
@export var foreground_items_target: Node;
@export var occluded_target: Node;


func _ready() -> void:
	for object in get_tree().get_nodes_in_group("LayeredObject"):
		object.background_items_target = background_items_target;
		object.visibility_occluder_target = visibility_occluder_target;
		object.foreground_items_target = foreground_items_target;
		object.occluded_target = occluded_target;

		object.separate_layers();

	for node in player_followers:
		if "target" in node:
			node.target = player;

	player.vision_cone = vision_cone;
