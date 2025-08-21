class_name HumanoidMovementJogBehaviour;
extends Behaviour;

func set_used_actions() -> Array[String]:
	return [
		"idle",
		"jog",
		"sprint"
	];

func transition_logic(input: InputPackage, _context: ContextPackage) -> String:
	if input.actions.has("sprint"):
		return "sprint";

	return "okay";

func choose_action(input: InputPackage, context: ContextPackage) -> void:
	if not context.states.has("ground"):
		switch_to("idle", input, context);
		return;

	if input.input_direction != Vector2.ZERO:
		switch_to("jog", input, context);
		return;

	switch_to("idle", input, context);
