extends Control
var notepad = FakeWindow

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_texture_button_button_down() -> void:
	var window =FakeWindow.new()
	$TextureRect.add_child(window)
