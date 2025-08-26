class_name UIInventoryAction;
extends Action;

func on_enter_action(_input: InputPackage, _context: ContextPackage) -> void:
	entity.open_inventory_panel();
	#entity.open_equipmnent_panel();

func on_exit_action(_new_action_name: String) -> void:
	entity.close_inventory_panel();
