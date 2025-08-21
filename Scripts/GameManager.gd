class_name GameManager;
extends Node;

@export var main: Node;
@export var ui: UIManager;

func _ready() -> void:
	ui.connect('trigger_pause', _trigger_pause);

func _trigger_pause(action: Definitions.TOGGLE_STATE) -> void:
	match action:
		Definitions.TOGGLE_STATE.TOGGLE:
			get_tree().paused = !get_tree().paused;

		Definitions.TOGGLE_STATE.ACTIVE:
			get_tree().paused = true;

		Definitions.TOGGLE_STATE.INACTIVE:
			get_tree().paused = false;

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED;

	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE;
