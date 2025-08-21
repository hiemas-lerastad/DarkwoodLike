class_name PlayerContextGatherer;
extends ContextGatherer;

@export var stats: Stats;

func gather_context(_input: InputPackage) -> ContextPackage:
	var new_context: ContextPackage = ContextPackage.new();

	new_context.states.append("ground");
	
	if stats:
		new_context.stats = stats;

	return new_context;
