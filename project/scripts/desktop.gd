extends Control
var windows:Array[FakeWindow]
var file_manager= FileManager.new()
@onready var desktop= $Desktop

func _ready() -> void:
	for n in desktop.get_children():
		if n is DesktopButton:
			n.connect("gui_input",_on_texture_button_button_down.bind(n))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_texture_button_button_down(event: InputEvent, button: DesktopButton) -> void:
	if event is InputEventMouseButton and event.pressed:
		var window = file_manager.open_file(button.path)
		window.mouse_filter=Control.MOUSE_FILTER_STOP
		windows.append(window)
		window.connect("gui_input",_on_window_clicked.bind(window))
		desktop.add_child(window)

func _on_window_clicked(event: InputEvent, window:FakeWindow):
	if event is InputEventMouseButton and event.pressed:
		window.move_to_front()
