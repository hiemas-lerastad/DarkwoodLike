class_name HumanoidPrimaryIdleBehaviour;
extends Behaviour;

func set_used_actions() -> Array[String]:
	return [
		"idle"
	];

func choose_action(input: InputPackage, context: ContextPackage) -> void:
	switch_to("idle", input, context);
