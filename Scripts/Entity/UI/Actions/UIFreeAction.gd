class_name UIFreeAction;
extends Action;

func on_enter_action(_input: InputPackage, _context: ContextPackage) -> void:
	entity.on_trigger_pause(Definitions.TOGGLE_STATE.INACTIVE);

func on_exit_action(_new_action_name: String) -> void:
	entity.on_trigger_pause(Definitions.TOGGLE_STATE.ACTIVE);
