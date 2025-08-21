class_name InventoryManager;
extends Control;

@export var containers: Array[InventoryContainer];

var held_item: Item;

func _ready() -> void:
	for container in containers:
		initialise_container(container);


func initialise_container(container: InventoryContainer) -> void:
	container.connect('item_held', _on_item_held);
	container.connect('item_placed', _on_item_placed);


func _on_item_held(item: Item) -> void:
	held_item = item;

	for container in containers:
		container.held_item = item;


func _on_item_placed(item: Item, target: InventoryContainer) -> void:
	held_item = null;

	for container in containers:
		if not container == target and container.items.has(item):
			container.items.remove_at(container.items.find(item));
			item.disconnect('item_entered', container._on_item_mouse_entered);
			item.disconnect('item_exited', container._on_item_mouse_exited);

		container.held_item = null;
