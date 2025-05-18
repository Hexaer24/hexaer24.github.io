extends Control

var file_associations := {
	"txt": Notepad,
	"": Notepad,
	"mp3": MusicPlayer,
	"flac": MusicPlayer,
	"tres":Notepad,
	"png": "ImageViewer"
}

func _ready() -> void:
	for n in get_children():
		if n is DesktopButton:
			n.connect("gui_input",_on_texture_button_button_down.bind(n))
	var window=create_window("res://presentable/text/welcome.tres")
	window.position=get_parent().size/3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func create_window(path):
	var window = open_file(path)
	window.mouse_filter=Control.MOUSE_FILTER_STOP
	window.connect("gui_input",_on_window_clicked.bind(window))
	add_child(window)
	return window
	

func _on_texture_button_button_down(event: InputEvent, button: DesktopButton) -> void:
	if event is InputEventMouseButton and event.pressed:
		var window =create_window(button.path)
		window.position=button.position

func _on_window_clicked(event: InputEvent, window:FakeWindow):
	if event is InputEventMouseButton and event.pressed:
		window.move_to_front()
	
func get_assigned_app(path):
	var extension = path.get_extension()
	if extension in file_associations:
		var app_name = file_associations[extension]
		return app_name
	else:
		print("No application associated with this file type: " + extension)
		return

func open_file(file_path: String):
	var app_name=get_assigned_app(file_path)
	var app_instance =app_name.new()
	app_instance.file_path=file_path
	return app_instance
