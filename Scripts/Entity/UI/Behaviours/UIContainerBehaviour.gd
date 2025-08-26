class_name UIContainerBehaviour;
extends Behaviour;

func set_used_actions() -> Array[String]:
	return [
		'container'
	];
	
func transition_logic(input: InputPackage, _context: ContextPackage) -> String:
	if input.actions.has('inventory'):
		return 'free';

	if input.actions.has('toggle'):
		return 'free';

	return 'okay';

func choose_action(input: InputPackage, context: ContextPackage) -> void:
	switch_to('container', input, context);
