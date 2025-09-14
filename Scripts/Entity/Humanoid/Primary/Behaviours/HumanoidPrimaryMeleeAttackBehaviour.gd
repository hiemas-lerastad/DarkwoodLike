class_name HumanoidPrimaryMeleeAttackBehaviour;
extends Behaviour;

func set_used_actions() -> Array[String]:
	return [
		"idle",
		"axe swing"
	];


func transition_logic(_input: InputPackage, _context: ContextPackage) -> String:
	if current_action.action_name == 'axe swing' and current_action.current_action_duration > 0.4:
		return "idle";

	return "okay";

func choose_action(input: InputPackage, context: ContextPackage) -> void:
	switch_to("axe swing", input, context);
