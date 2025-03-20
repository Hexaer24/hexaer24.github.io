extends Control
var windows:Array[FakeWindow]
var file_manager= FileManager.new()

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_texture_button_button_down() -> void:
	var window = file_manager.open_file("res://text/first_summer_job.txt")
	window.mouse_filter=Control.MOUSE_FILTER_STOP
	windows.append(window)
	window.connect("gui_input",_on_window_clicked.bind(window))
	$Desktop.add_child(window)

func _on_window_clicked(event: InputEvent, window:FakeWindow):
	if event is InputEventMouseButton and event.pressed:
		window.move_to_front()
