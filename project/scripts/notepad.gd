class_name Notepad extends FakeWindow
func _ready() -> void:
	style_path="res://assets/notepadGUI.png"
	theme_path="res://resources/notepadGUI.tres"
	super._ready()

func loadContent():
	var content = RichTextLabel.new()
	content.append_text(get_txt_content("res://text/first_summer_job.txt"))
	content.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	content.size_flags_vertical = Control.SIZE_EXPAND_FILL
	content.custom_minimum_size = Vector2(100, 100) # Set a reasonable size
	content.bbcode_enabled=true
	return content

func get_txt_content(filePath):
	var file = FileAccess.open(filePath, FileAccess.READ)
	var content = file.get_as_text()
	return content
