class_name DesktopButton extends Button
@export_file() var path

func _ready() -> void:
	focus_mode=Control.FOCUS_NONE
	theme_type_variation="DesktopButton"
