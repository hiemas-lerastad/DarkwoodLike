class_name UIManager;
extends Entity;

@export var inventory: InventoryContainer;
@export var container_scene: PackedScene;
@export var inventory_manager: InventoryManager;
@export var cursor: Node2D;
@export var cursor_container: Node2D;

var container: InventoryContainer;

signal trigger_pause;
signal close_container;


func _ready() -> void:
	inventory_manager.connect('close_container', _close_container);


func _process(_delta: float) -> void:
	update_cursor();


func open_container(data: InventoryData, id: String) -> void:
	container = container_scene.instantiate();
	container.set_state(Definitions.UI_STATE.OPEN);
	input_gatherer.trigger_container = true;
	container.data = data;
	container.id = id;

	inventory_manager.add_child(container);
	inventory_manager.initialise_container(container);
	inventory_manager.containers.append(container);


func on_trigger_pause(value: Definitions.TOGGLE_STATE) -> void:
	trigger_pause.emit(value);


func open_inventory_panel() -> void:
	inventory.set_state(Definitions.UI_STATE.OPEN);


func close_inventory_panel() -> void:
	inventory.set_state(Definitions.UI_STATE.CLOSED);


func open_container_panel() -> void:
	if container:
		container.set_state(Definitions.UI_STATE.OPEN);


func close_container_panel() -> void:
	if container:
		container.set_state(Definitions.UI_STATE.CLOSED);
		inventory_manager.remove_container(container);


func _close_container(data: InventoryData, id: String) -> void:
	close_container.emit(data, id);


func update_cursor() -> void:
	cursor.global_position = cursor_container.get_global_mouse_position();
