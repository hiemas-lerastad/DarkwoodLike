class_name ObjectLayerManager;
extends Node;

@export_group('Internal')
@export var background_items: Array[Node];
@export var visibility_occluders: Array[Node];
@export var foreground_items: Array[Node];
@export var occluded_items: Array[Node];

var background_items_target: Node;
var visibility_occluder_target: Node;
var foreground_items_target: Node;
var occluded_target: Node;


func separate_layers() -> void:
	for item in background_items:
		item.reparent(background_items_target, true);

	for item in visibility_occluders:
		item.reparent(visibility_occluder_target, true);

	for item in foreground_items:
		item.reparent(foreground_items_target, true);

	for item in occluded_items:
		item.reparent(occluded_target, true);


func recombine_layers() -> void:
	for item in visibility_occluders:
		item.reparent(self, true);

	for item in foreground_items:
		item.reparent(self, true);

	for item in occluded_items:
		item.reparent(self, true);
