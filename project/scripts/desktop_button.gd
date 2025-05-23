class_name DesktopButton extends TextureButton
@export_file() var path
@export var opt_title:String
@onready var os=$"../.."

func _ready() -> void:
	focus_mode=Control.FOCUS_NONE
	theme_type_variation="DesktopButton"
	var label=Label.new()
	add_child(label)
	var split_path = path.split("/")
	label.text=split_path[-1] if split_path[0]!="uid:" else opt_title
	label.position.y=-10
