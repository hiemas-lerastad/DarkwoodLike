class_name InteractableContainer;
extends Interactable;

signal open_container;

@export var id: String;
@export var data: InventoryData;


func on_interact() -> void:
	open_container.emit(data, id);
