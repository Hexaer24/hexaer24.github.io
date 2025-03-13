class_name Notepad extends FakeWindow

func _ready() -> void:
	style_path="res://assets/notepadGUI.png"
	theme_path="res://resources/notepadGUI.tres"
	app_name="Notepad"
	super._ready()

func loadTitleName():
	var title_tab_container = PanelContainer.new()
	title_tab_container.size_flags_horizontal=Control.SIZE_FILL
	var title_tab=TabBar.new()
	title_tab.add_tab("Current")
	title_tab.add_tab("other")
	title_tab_container.add_child(title_tab)
	return title_tab_container

func loadContent():
	var content = baseContent()
	var background=ColorRect.new()
	background.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	background.size_flags_vertical = Control.SIZE_EXPAND_FILL
	background.color=Color(0.2,0.2,0.2)
	background.custom_minimum_size = Vector2(100, 100)
	background.z_index=0
	var text_content = RichTextLabel.new()
	text_content.append_text(get_txt_content("res://text/first_summer_job.txt"))
	text_content.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	text_content.size_flags_vertical = Control.SIZE_EXPAND_FILL
	text_content.custom_minimum_size = Vector2(100, 100) # Set a reasonable size
	text_content.bbcode_enabled=true
	content.add_child(background)
	content.add_child(text_content)
	return content

func get_txt_content(filePath):
	var file = FileAccess.open(filePath, FileAccess.READ)
	var content = file.get_as_text()
	return content
