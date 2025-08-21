class_name Action;
extends Node;

var entity: Entity;
var behaviour_manager: BehaviourManager;

@export var action_name: String;

var enter_action_time: float;

func update(input: InputPackage, context: ContextPackage, delta: float) -> void:
	entity.move_and_slide();
	process_input_vector(input, context, delta);
	_update(input, context, delta);

func _update(_input: InputPackage, _context: ContextPackage, _delta: float) -> void:
	pass;

func on_enter_action(_input: InputPackage, _context: ContextPackage) -> void:
	pass;

func on_exit_action(_new_action_name: String) -> void:
	pass;

func process_input_vector(_input: InputPackage, _context: ContextPackage, _delta: float) -> void:
	pass;
