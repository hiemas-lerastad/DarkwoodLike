class_name Item;
extends Control;

@export var area: Area2D;
@export var grid_items: Array[Vector2i] = [Vector2i.ZERO];
@export var collision_block: RectangleShape2D;

var cell_size: Vector2 = Vector2(64.0, 64.0);
var anchor_slot: InventorySlot;
var slots: Array[InventorySlot];

signal item_entered;
signal item_exited;

func initialise() -> void:
	for grid_item in grid_items:
		var collision_shape: CollisionShape2D = CollisionShape2D.new();
		var shape: RectangleShape2D = RectangleShape2D.new();
		shape.size = cell_size;
		collision_shape.shape = shape;
		collision_shape.position = (Vector2(grid_item.x, grid_item.y) * cell_size);
		area.add_child(collision_shape);
		
		var color_rect: ColorRect = ColorRect.new();
		color_rect.size = cell_size;
		color_rect.position = (Vector2(grid_item.x, grid_item.y) * cell_size) - Vector2(cell_size.x, cell_size.y) / 2;
		color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE;
		add_child(color_rect)

func rotate() -> void:
	var new_grid_items: Array[Vector2i] = [];

	for grid_item in grid_items:
		new_grid_items.append(Vector2i(-grid_item.y, grid_item.x));

	rotation_degrees += 90.0;
		
	grid_items = new_grid_items;
		

func _on_area_2d_mouse_entered() -> void:
	item_entered.emit(self);

func _on_area_2d_mouse_exited() -> void:
	item_exited.emit(self);
