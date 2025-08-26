class_name UIFreeBehaviour;
extends Behaviour;

func set_used_actions() -> Array[String]:
	return [
		'free'
	];
	
func transition_logic(input: InputPackage, _context: ContextPackage) -> String:
	if input.actions.has('container'):
		return 'container';

	if input.actions.has('inventory'):
		return 'inventory';

	if input.actions.has('toggle'):
		return 'pause';

	return 'okay';

func choose_action(input: InputPackage, context: ContextPackage) -> void:
	switch_to('free', input, context);
