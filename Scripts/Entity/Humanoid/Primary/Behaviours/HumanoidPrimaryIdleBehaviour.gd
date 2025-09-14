class_name HumanoidPrimaryIdleBehaviour;
extends Behaviour;

func set_used_actions() -> Array[String]:
	return [
		"idle",
		"aim"
	];

func transition_logic(input: InputPackage, _context: ContextPackage) -> String:
	if input.actions.has('melee'):
		return 'melee';

	return "okay";

func choose_action(input: InputPackage, context: ContextPackage) -> void:
	if input.actions.has('aim'):
		switch_to("aim", input, context);
	else:
		switch_to("idle", input, context);
