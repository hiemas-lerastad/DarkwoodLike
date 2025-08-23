class_name UIManager;
extends CanvasLayer;

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


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_action_inventory"):
		match inventory.state:
			Definitions.UI_STATE.OPEN:
				inventory.set_state(Definitions.UI_STATE.CLOSED);
				trigger_pause.emit(Definitions.TOGGLE_STATE.INACTIVE);
				
				if container:
					container.set_state(Definitions.UI_STATE.CLOSED);
					inventory_manager.remove_container(container);

			Definitions.UI_STATE.CLOSED:
				inventory.set_state(Definitions.UI_STATE.OPEN);
				trigger_pause.emit(Definitions.TOGGLE_STATE.ACTIVE);

	if Input.is_action_just_pressed("ui_action_toggle"):
		if inventory.state == Definitions.UI_STATE.OPEN:
			inventory.set_state(Definitions.UI_STATE.CLOSED);

		if container and container.state == Definitions.UI_STATE.OPEN:
			container.set_state(Definitions.UI_STATE.CLOSED);
			inventory_manager.remove_container(container);
			container = null;

		trigger_pause.emit(Definitions.TOGGLE_STATE.INACTIVE);


func open_container(data: InventoryData, id: String) -> void:
	trigger_pause.emit(Definitions.TOGGLE_STATE.ACTIVE);

	container = container_scene.instantiate();
	container.set_state(Definitions.UI_STATE.OPEN);
	container.data = data;
	container.id = id;

	inventory_manager.add_child(container);
	inventory_manager.initialise_container(container);
	inventory_manager.containers.append(container);

	inventory.set_state(Definitions.UI_STATE.OPEN);


func _close_container(data: InventoryData, id: String) -> void:
	close_container.emit(data, id);


func update_cursor() -> void:
	cursor.global_position = cursor_container.get_global_mouse_position();
