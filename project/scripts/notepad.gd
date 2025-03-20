class_name Notepad extends FakeWindow
func _ready() -> void:
	style_path="res://assets/notepadGUI.png"
	theme_path="res://resources/notepadGUI.tres"
	app_name="Notepad"
	super._ready()

func createWindow():
	var tabbar=loadTabBar()
	add_child(tabbar)
	super.createWindow()
	tabbar.add_tab("waza")
	(print("is tabbar:", tabbar.size))

func loadTabBar():
	var title_content= TabBar.new()
	title_content.size=Vector2(30,10)
	return title_content

func openFile(path):
	var content_text=RichTextLabel.new()
	content_text.append_text(get_txt_content(path))
	content_text.bbcode_enabled=true
	return content_text

func loadContent():
	var content = PanelContainer.new()
	content.size_flags_vertical=Control.SIZE_EXPAND_FILL
	
	var background = ColorRect.new()
	background.color= Color(0.2,0.2,0.2)
	
	var content_text= openFile("res://text/first_summer_job.txt")

	content.add_child(background)
	content.add_child(content_text)
	return content

func get_txt_content(filePath):
	var file = FileAccess.open(filePath, FileAccess.READ)
	var content = file.get_as_text()
	return content
