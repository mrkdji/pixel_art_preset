@tool
extends Control

@onready var tile_size_spin_box: SpinBox = %TileSizeSpinBox
@onready var width_in_tiles_spin_box: SpinBox = %WidthInTilesSpinBox
@onready var height_in_tiles_spin_box: SpinBox = %HeightInTilesSpinBox
@onready var test_scale_spin_box: SpinBox = %TestScaleSpinBox
@onready var scale_mode_option_button: OptionButton = %ScaleModeOptionButton
@onready var stretch_mode_option_button: OptionButton = %StretchModeOptionButton
@onready var apply_button: Button = %ApplyButton

const SCALE_MODES = [
	"fractional",
	"integer"
]

const STRETCH_MODES = [
	"disabled",
	"canvas_items",
	"viewport"
]

func _ready():
	tile_size_spin_box.value = ProjectSettings.get_setting("display/window/size/tile_size", 16)
	width_in_tiles_spin_box.value = ProjectSettings.get_setting("display/window/size/width_in_tiles", 16)
	width_in_tiles_spin_box.value = ProjectSettings.get_setting("display/window/size/width_in_tiles", 16)
	height_in_tiles_spin_box.value = ProjectSettings.get_setting("display/window/size/height_in_tiles", 9)
	test_scale_spin_box.value = ProjectSettings.get_setting("display/window/size/test_scale", 2)
	
	# Initializing Scale Mode
	for i in SCALE_MODES.size():
		var mode = SCALE_MODES[i]
		scale_mode_option_button.add_item(mode, i)

	var scale_mode = SCALE_MODES.find(ProjectSettings.get_setting("display/window/stretch/scale_mode"))
	scale_mode_option_button.select(scale_mode)
	
	setup_option_button(STRETCH_MODES, stretch_mode_option_button, "display/window/stretch/mode")
	
	apply_button.pressed.connect(_on_apply_pressed)


func setup_option_button(options, option_button, setting_name):
	for i in options.size():
		var option = options[i]
		option_button.add_item(option, i)

	var option = options.find(ProjectSettings.get_setting(setting_name))
	option_button.select(option)


func _on_apply_pressed():
	var tile_size = tile_size_spin_box.value
	var width_in_tiles = width_in_tiles_spin_box.value
	var height_in_tiles = height_in_tiles_spin_box.value
	var test_scale = test_scale_spin_box.value
	var viewport_width = int(width_in_tiles * tile_size)
	var viewport_height = int(height_in_tiles * tile_size)
	var scale_mode = SCALE_MODES[scale_mode_option_button.selected]
	var stretch_mode = STRETCH_MODES[stretch_mode_option_button.selected]
	
	ProjectSettings.set_setting("display/window/size/tile_size", tile_size)
	ProjectSettings.set_setting("display/window/size/width_in_tiles", width_in_tiles)
	ProjectSettings.set_setting("display/window/size/height_in_tiles", height_in_tiles)
	ProjectSettings.set_setting("display/window/size/test_scale", test_scale)
	ProjectSettings.set_setting("display/window/size/viewport_width", viewport_width)
	ProjectSettings.set_setting("display/window/size/viewport_height", viewport_height)
	ProjectSettings.set_setting("display/window/size/window_width_override", viewport_width * test_scale)
	ProjectSettings.set_setting("display/window/size/window_height_override", viewport_height * test_scale)
	
	ProjectSettings.set_setting("display/window/stretch/scale_mode", scale_mode)
	ProjectSettings.set_setting("display/window/stretch/mode", stretch_mode)
	
	
	
	ProjectSettings.save()
