class_name CameraManager;
extends Camera2D;

func _enter_tree() -> void:
	GLOBALS.camera = self;
