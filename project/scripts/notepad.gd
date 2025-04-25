class_name Notepad extends FakeWindow

func _ready() -> void:
	style_path="res://assets/notepadGUI.png"
	theme_path="res://resources/notepadGUI.tres"
	app_name="Notepad"
	super._ready()

"""func loadTitleName():
	var title_tab_container = PanelContainer.new()
	title_tab_container.size_flags_horizontal=Control.SIZE_FILL
	var title_tab=TabBar.new()
	title_tab.add_tab("Current")
	title_tab.add_tab("other")
	title_tab_container.add_child(title_tab)
	return title_tab_container"""

# Doesn't work in html, should load form TextFile resource instead!
func openFile(path):
	var text_res=load(path) as TextResource
	windows[self]= path
	var content_text=RichTextLabel.new()
	content_text.append_text(text_res.text)
	content_text.bbcode_enabled=true
	return content_text

func loadContent():
	var content = baseContent()
	
	var background = ColorRect.new()
	background.color= Color(0.2,0.2,0.2)
	
	var content_text= openFile(file_path)

	content.add_child(background)
	content.add_child(content_text)
	return content

func get_txt_content(filePath):
	var file = FileAccess.open(filePath, FileAccess.READ)
	var content = file.get_as_text()
	return content
