class_name LightingManager;
extends Node2D;

@export_range(0.0, 1.0, 0.01) var ambient_light_amount: float = 0.2:
	set(value):
		ambient_light_amount = value;

		if ambient_light:
			update_light();

@export var ambient_light: CanvasModulate;
@export var lights: Array[Light2D];


func _ready() -> void:
	update_light();


func update_light() -> void:
	ambient_light.visible = true;
	ambient_light.color = Color(ambient_light_amount, ambient_light_amount, ambient_light_amount, 1.0);
	
	for light in lights:
		light.energy = 1.0 - ambient_light_amount;
