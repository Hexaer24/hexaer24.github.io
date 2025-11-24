class_name DesktopButton extends VBoxContainer
@export var path:String
@export var opt_title:String
@onready var desktop:Desktop=Broadcast.desktop
var background
var extension
var icon_button=TextureButton.new()

func _ready() -> void:
	add_child(icon_button)
	focus_mode=Control.FOCUS_NONE
	var label=Label.new()
	add_child(label)
	icon_button.connect("gui_input",desktop._on_texture_button_button_down.bind(self))
	var split_path = path.split("/")
	extension=split_path[-1].split(".")[-1]
	if split_path[0]!="uid:":
		label.text=split_path[-1]
		set_button(extension)
	else:
		label.text=opt_title
		set_button("tres")

func set_button(ext):
	match ext:
		"txt","tres":
			icon_button.texture_normal= load("res://assets/notepad.png")
			icon_button.texture_hover=load("res://assets/notepad-hover.png")
		"":
			icon_button.texture_normal = load("res://assets/folder.png")
		_:
			icon_button.texture_normal=load("res://assets/disk.png")
			icon_button.texture_hover=null
	
