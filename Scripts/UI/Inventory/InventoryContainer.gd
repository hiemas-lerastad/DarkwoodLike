class_name InventoryContainer;
extends Control;

signal item_held;
signal item_placed;

@export_group("Settings")
@export var state: Definitions.UI_STATE = Definitions.UI_STATE.CLOSED;
@export var data: InventoryData;

@export_group("Constants")
@export var slot_scene: PackedScene;
@export var slot_container: GridContainer;
@export var offset_container: MarginContainer;
@export var item_scene: PackedScene;
@export var cell_size: Vector2 = Vector2(64.0, 64.0);

var grid_size: Vector2i = Vector2i.ZERO;
var grid_data: Array2D = Array2D.new();
var current_slot: InventorySlot;
var held_item: Item;
var hovered_item: Item;
var can_place: bool = false;
var initialised: bool = false;
var items: Array[Item];
var slots: Array[Node];
var id: String;
var offset: Vector2;


func _load_data() -> void:
	offset = data.offset;
	
	offset_container.add_theme_constant_override("margin_left", int((offset * cell_size).x));
	offset_container.add_theme_constant_override("margin_top", int((offset * cell_size).y));

	for slot_index in data.slot_data.size():
		var slot_data: SlotData = data.slot_data[slot_index];
		var new_slot: InventorySlot = slot_scene.instantiate();

		new_slot.id = slot_index;
		new_slot.disable = slot_data.disabled;
		new_slot.disable_visuals = slot_data.visuals_disabled;
		new_slot.cell_size = cell_size;

		new_slot.slot_entered.connect(_on_slot_mouse_entered);
		new_slot.slot_exited.connect(_on_slot_mouse_exited);

		new_slot.initialise();

		grid_data.set_value_index(slot_index, new_slot);

		slot_container.add_child(new_slot);

	for item_data in data.item_data:
		var item: Item = item_scene.instantiate();
		item.grid_items = item_data.grid_items;
		item.cell_size = cell_size;
		item.initialise();

		add_child(item);

		place_item_at_slot.call_deferred(item, item_data.slot);


func _ready() -> void:
	grid_size = data.grid_size;
	grid_data.initialise_size(grid_size.x, grid_size.y);
	slot_container.columns = grid_size.x;


func _on_item_mouse_entered(item: Item) -> void:
	if hovered_item != item:
		hovered_item = item;


func _on_item_mouse_exited(item: Item) -> void:
	if hovered_item == item:
		hovered_item = null;


func _on_slot_mouse_entered(slot: InventorySlot) -> void:
	if current_slot != slot:
		current_slot = slot;

	if held_item:
		can_place = validate_placement(slot);


func _on_slot_mouse_exited(slot: InventorySlot) -> void:
	if not held_item:
		slot.visual.color = Color(0.0, 0.0, 0.0, 0.5);

	if current_slot == slot:
		current_slot = null;


func validate_placement(slot: InventorySlot) -> bool:
	var slot_coord: Vector2i = grid_data.get_coord_from_index(slot.id);

	for grid_item in held_item.grid_items:
		var coord_to_check: Vector2i = slot_coord + grid_item;

		if not grid_data.is_valid_coord(coord_to_check.x, coord_to_check.y):
			return false;

		var slot_to_check: InventorySlot = grid_data.get_value(coord_to_check.x, coord_to_check.y);
		if slot_to_check.disable:
			return false;

		if slot_to_check.stored_item and \
			slot_to_check.stored_item != held_item:
			return false;

	return true;


func grab_item() -> void:
	held_item = hovered_item;
	hovered_item = null;
	held_item.global_position = get_global_mouse_position();

	if current_slot:
		current_slot.visual.color = Color(0.0, 0.0, 0.0, 0.5);

	item_held.emit(held_item);

	if held_item.anchor_slot:
		can_place = validate_placement(current_slot);


func place_item_at_slot(item: Item, slot_id: int) -> void:
	var anchor_slot: InventorySlot = grid_data.get_value_index(slot_id);

	item.reparent(self);

	if not items.has(item):
		items.append(item);
		item.connect('item_entered', _on_item_mouse_entered);
		item.connect('item_exited', _on_item_mouse_exited);

	item.global_position = anchor_slot.global_position + Vector2(32.0, 32.0);

	if item.anchor_slot:
		item.anchor_slot.stored_item = null;
		
		for slot in item.slots:
			slot.stored_item = null;

	item.slots = [];

	var slot_coord: Vector2i = grid_data.get_coord_from_index(slot_id);

	for grid_item in item.grid_items:
		var coord_to_check: Vector2i = slot_coord + grid_item;

		if grid_data.is_valid_coord(coord_to_check.x, coord_to_check.y):
			var slot: InventorySlot = grid_data.get_value(coord_to_check.x, coord_to_check.y);
			slot.stored_item = item;
			item.slots.append(slot);

	item.anchor_slot = anchor_slot;


func place_item() -> void:
	if current_slot and held_item:
		place_item_at_slot(held_item, current_slot.id);

		can_place = false;
		hovered_item = held_item;
		item_placed.emit(held_item, self);

func rotate_item() -> void:
	held_item.rotate();

	can_place = current_slot and validate_placement(current_slot);


func _physics_process(_delta):
	if held_item:
		held_item.global_position = get_global_mouse_position();

		if Input.is_action_just_pressed("ui_action_interact_secondary") and is_ancestor_of(held_item):
			rotate_item();
 
		if can_place and Input.is_action_just_pressed("ui_action_interact"):
			place_item();
	else:
		if hovered_item and is_ancestor_of(hovered_item) and Input.is_action_just_pressed("ui_action_interact"):
			grab_item();


func set_state(new_state: Definitions.UI_STATE) -> void:
	state = new_state;

	match new_state:
		Definitions.UI_STATE.OPEN:
			visible = true;

			if not initialised:
				initialised = true;

				_load_data.call_deferred();

		Definitions.UI_STATE.CLOSED:
			visible = false;


func update_data() -> InventoryData:
	var new_data: InventoryData = InventoryData.new();
	new_data.grid_size = grid_size;

	for slot in grid_data.values:
		var slot_data: SlotData = SlotData.new();
		slot_data.disabled = slot.disable;
		slot_data.visuals_disabled = slot.disable_visuals;
		new_data.slot_data.append(slot_data);

	for item in items:
		var item_data: ItemData = ItemData.new();
		item_data.slot = item.anchor_slot.id;
		item_data.grid_items = item.grid_items;
		new_data.item_data.append(item_data);

	data = new_data;

	return new_data;
