class_name FakeWindow extends PanelContainer
var titleBar
var dragging :=false
var drag_offset := Vector2.ZERO
var resizing := false
var resize_direction := Vector2.ZERO
var drag_start_pos := Vector2.ZERO
var drag_start_size := Vector2.ZERO
var min_size := Vector2(100, 100)  # Minimum window size
var max_size := Vector2(1000,600)



func _ready() -> void:
	size =Vector2(400,200)
	loadTitle()
	loadStyle()
	loadResize()
	titleBar.connect("gui_input", _on_titlebar_gui_input)
	add_child(titleBar)
	
func _process(_delta: float) -> void:
	pass
func loadResize():
	var resize_handle = Control.new()
	resize_handle.custom_minimum_size = Vector2(20, 20)  # Resize area size
	resize_handle.anchor_left =1.0
	resize_handle.anchor_right =1.0
	resize_handle.anchor_top =1.0
	resize_handle.anchor_bottom =1.0
	resize_handle.size_flags_vertical =Control.SIZE_SHRINK_END
	resize_handle.size_flags_horizontal =Control.SIZE_SHRINK_END
	resize_handle.mouse_default_cursor_shape = Control.CURSOR_FDIAGSIZE
	resize_handle.connect("gui_input", _on_resize_handle_input)
	add_child(resize_handle)

func loadStyle():
	theme= load("res://resources/notepadGUI.tres")#Remove when specialized
	var stylebox =StyleBoxFlat.new()
	stylebox.bg_color = Color(0.2, 0.2, 0.2, 1)
	add_theme_stylebox_override("panel", stylebox)
	
	var titleBarStyle= StyleBoxTexture.new()
	titleBarStyle.texture = load("res://assets/notepadGUI.png")
	titleBar.add_theme_stylebox_override("panel", theme.get_stylebox("panel", "PanelContainer"))
	

func loadTitle():
	titleBar=PanelContainer.new()
	titleBar.size_flags_horizontal =Control.SIZE_EXPAND_FILL
	titleBar.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
	titleBar.custom_minimum_size = Vector2(0, 20)
	loadClose()
	
	
func loadClose():
	var close = Button.new()
	var closeTexture: AtlasTexture =AtlasTexture.new()
	var fullscreen
	
	close.anchor_left=1
	close.anchor_right=1
	close.custom_minimum_size=Vector2(20,20)
	close.size_flags_horizontal =Control.SIZE_SHRINK_END
	closeTexture = load("res://assets/notepadGUI.png")
	closeTexture.region = Rect2(550,90,90,90)
	close.add_theme_stylebox_override("panel",theme.get_stylebox("panel","PanelContainer"))
	titleBar.add_child(close)
	
func _on_titlebar_gui_input(event):
	if event is InputEventMouseButton:
		dragging = event.pressed
		drag_offset = event.position if dragging else drag_offset
	elif event is InputEventMouseMotion and dragging:
		global_position += event.position - drag_offset
		
func _on_resize_handle_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			resizing = true
			drag_start_pos = event.global_position
			drag_start_size = size
		else:
			resizing = false
	elif event is InputEventMouseMotion and resizing:
		var delta = event.global_position - drag_start_pos
		var new_size = drag_start_size + delta
		size = new_size.clamp(min_size, max_size)  # Ensure min/max limits
