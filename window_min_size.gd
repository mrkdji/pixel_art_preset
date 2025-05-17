extends Node


func _ready() -> void:
	set_window_min_size()


func set_window_min_size() -> void:
	var min_size = Vector2.ZERO
	min_size.x = ProjectSettings.get_setting('display/window/size/viewport_width')
	min_size.y = ProjectSettings.get_setting('display/window/size/viewport_height')
	get_window().min_size = min_size


func _exit_tree() -> void:
	get_window().min_size = Vector2.ZERO
