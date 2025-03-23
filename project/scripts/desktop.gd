extends Control
@onready var desktop= $Desktop

var file_associations := {
	"txt": Notepad,
	"mp3": "MusicPlayer",
	"png": "ImageViewer"
}

func _ready() -> void:
	for n in desktop.get_children():
		if n is DesktopButton:
			n.connect("gui_input",_on_texture_button_button_down.bind(n))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_texture_button_button_down(event: InputEvent, button: DesktopButton) -> void:
	if event is InputEventMouseButton and event.pressed:
		var window = open_file(button.path)
		window.mouse_filter=Control.MOUSE_FILTER_STOP
		window.connect("gui_input",_on_window_clicked.bind(window))
		desktop.add_child(window)

func _on_window_clicked(event: InputEvent, window:FakeWindow):
	if event is InputEventMouseButton and event.pressed:
		window.move_to_front()

func open_file(file_path: String):
	var extension = file_path.get_extension()
	if extension in file_associations:
		var app_name = file_associations[extension]
		var app_instance =app_name.new()
		app_instance.file_path=file_path
		app_instance.openFile(file_path)
		return app_instance
	else:
		print("No application associated with this file type: " + extension)
		return
