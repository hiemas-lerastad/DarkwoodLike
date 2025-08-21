class_name InventorySlot;
extends Control;

signal slot_entered;
signal slot_exited;
signal slot_item_entered;
signal slot_item_exited;

@export var id: int;
@export var visual: ColorRect;
@export var area: Area2D;
@export var disable: bool = false;
@export var disable_visuals: bool = false;
@export var collision_block: RectangleShape2D;

var stored_item: Item;
var cell_size: Vector2 = Vector2(64.0, 64.0);

func initialise() -> void:
	if disable:
		area.monitorable = false;
		area.monitoring = false;

	else:
		var collision_shape: CollisionShape2D = CollisionShape2D.new();
		var shape: RectangleShape2D = RectangleShape2D.new();
		shape.size = cell_size;
		collision_shape.shape = shape;
		area.add_child(collision_shape);

	if not disable_visuals:
		var color_rect: ColorRect = ColorRect.new();
		color_rect.size = cell_size;
		color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE;
		color_rect.color = Color(0.0, 0.0, 0.0, 0.5);
		visual = color_rect;
		add_child(color_rect)

func _on_area_2d_mouse_entered() -> void:
	slot_entered.emit(self);

func _on_area_2d_mouse_exited() -> void:
	slot_exited.emit(self);

func _on_area_2d_area_entered(contact_area: Area2D) -> void:
	if contact_area.get_parent() is Item:
		slot_item_entered.emit(self, contact_area.get_parent());

func _on_area_2d_area_exited(contact_area: Area2D) -> void:
	if contact_area.get_parent() is Item:
		slot_item_exited.emit(self, contact_area.get_parent());
