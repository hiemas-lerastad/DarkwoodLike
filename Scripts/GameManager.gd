class_name GameManager;
extends Node;

@export var main: Node;
@export var player: Player;
@export var ui: UIManager;

var interactables: Array[Node];


func _ready() -> void:
	ui.connect('trigger_pause', _trigger_pause);
	ui.connect('close_container', _close_container);
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN;

	interactables = get_tree().get_nodes_in_group("Interactable");

	for interactable in interactables:
		interactable.player = player;
		interactable.connect('can_interact', _on_can_interact);
		interactable.connect('interacted', _on_interact);
		
		if interactable is InteractableContainer:
			interactable.connect('open_container', _on_open_container);


func _on_can_interact(interactable: Interactable, state: bool) -> void:
	if not get_tree().paused:
		interactable.interactable = state;


func _on_interact(interactable: Interactable) -> void:
	if not get_tree().paused:
		interactable.on_interact();


func _on_open_container(data: InventoryData, container_id: String) -> void:
	if not get_tree().paused:
		ui.open_container(data, container_id);


func _close_container(data: InventoryData, container_id: String) -> void:
	var container: InteractableContainer = interactables[interactables.find_custom(_get_container_by_id.bind(container_id))];

	container.data = data;


func _trigger_pause(action: Definitions.TOGGLE_STATE) -> void:
	match action:
		Definitions.TOGGLE_STATE.TOGGLE:
			get_tree().paused = !get_tree().paused;

		Definitions.TOGGLE_STATE.ACTIVE:
			get_tree().paused = true;

		Definitions.TOGGLE_STATE.INACTIVE:
			get_tree().paused = false;
	
	if get_tree().paused:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN;
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN;


func _get_container_by_id(item: Interactable, id: String) -> bool:
	return item.id == id;
