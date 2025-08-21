class_name UIManager;
extends CanvasLayer;

@export var inventory: InventoryContainer;
@export var test_container: InventoryContainer;

signal trigger_pause;

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_action_inventory"):
		match inventory.state:
			Definitions.UI_STATE.OPEN:
				inventory.set_state(Definitions.UI_STATE.CLOSED);
				test_container.set_state(Definitions.UI_STATE.CLOSED);
				trigger_pause.emit(Definitions.TOGGLE_STATE.INACTIVE);

			Definitions.UI_STATE.CLOSED:
				inventory.set_state(Definitions.UI_STATE.OPEN);
				test_container.set_state(Definitions.UI_STATE.OPEN);
				trigger_pause.emit(Definitions.TOGGLE_STATE.ACTIVE);
