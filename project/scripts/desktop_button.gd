class_name DesktopButton extends TextureButton
@export_file() var path
@export var opt_title:String
@onready var os=$"../.."
var background
var extension

func _ready() -> void:
	focus_mode=Control.FOCUS_NONE
	theme_type_variation="DesktopButton"
	var label=Label.new()
	add_child(label)
	var split_path = path.split("/")
	extension=split_path[-1].split(".")[-1]
	if split_path[0]!="uid:":
		label.text=split_path[-1]
		set_icon(extension)
	else:
		label.text=opt_title
		set_icon("txt")
	label.position.y=-10
	
func set_icon(extension):
	var assign=func(path):
		var new_texture:Texture2D=load(path)
		texture_hover=new_texture
	match extension:
		"txt":
			assign.call("res://assets/notepad-hover.png")
		_:
			texture_hover=null
