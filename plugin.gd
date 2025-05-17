@tool
extends EditorPlugin

const PIXEL_ART_PRESET_SETTINGS = preload("res://addons/pixel_art_preset/pixel_art_preset_settings.tscn")
var dock_instance;

func _enter_tree():
	print("Initialize pixelart preset")
	add_autoload_singleton("window_min_size", "res://addons/pixel_art_preset/window_min_size.gd");
	ProjectSettings.set_setting("rendering/textures/canvas_textures/default_texture_filter", "nearest")
	ProjectSettings.set_setting("rendering/2d/snap/snap_2d_transforms_to_pixel", true)
	ProjectSettings.set_setting("rendering/2d/snap/snap_2d_vertices_to_pixel", true)
	ProjectSettings.save()
	
	dock_instance = PIXEL_ART_PRESET_SETTINGS.instantiate()
	add_control_to_dock(DOCK_SLOT_LEFT_UR, dock_instance)


func _exit_tree():
	remove_autoload_singleton("window_min_size")
	remove_control_from_docks(dock_instance)
	dock_instance.queue_free()
