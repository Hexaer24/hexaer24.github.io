class_name DesktopButton extends TextureButton
@export_file() var path
@export var opt_title:String
@onready var os=$"../.."
var background

func _ready() -> void:
	focus_mode=Control.FOCUS_NONE
	theme_type_variation="DesktopButton"
	var label=Label.new()
	add_child(label)
	var split_path = path.split("/")
	if split_path[0]!="uid:":
		label.text=split_path[-1]
		set_icon(split_path[-1])
	else:
		label.text=opt_title
		set_icon(".txt")
	label.position.y=-10
	
func set_icon(extension):
	
	match extension:
		".txt":
			texture_hover=Texture2D.new()
