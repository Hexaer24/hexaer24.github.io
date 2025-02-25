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
var is_maximized = false
var style =load("res://assets/notepadGUI.png")
var prev_size = Vector2.ZERO
var prev_position
var button_size = Vector2(20,20)

func _ready() -> void:
	size =Vector2(400,200)
	position = Vector2(250,250)
	prev_position=position
	loadTitle()
	loadStyle()
	loadResize()
	titleBar.connect("gui_input", _on_titlebar_gui_input)
	add_child(titleBar)
	
func _process(_delta: float) -> void:
	pass
func loadResize():
	var resize_handle = Control.new()
	resize_handle.custom_minimum_size = button_size  # Resize area size
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
	titleBar.add_theme_stylebox_override("panel", theme.get_stylebox("panel", "PanelContainer"))
	

func loadTitle():
	titleBar=PanelContainer.new()
	titleBar.size_flags_horizontal =Control.SIZE_EXPAND_FILL
	titleBar.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
	titleBar.custom_minimum_size.y =  20
	titleBar.size_flags_stretch_ratio=0
	loadButtons()
	
func createButton(region)->Button:
	var button:Button = Button.new()
	button.custom_minimum_size=button_size
	
	var texture_container: TextureRect=TextureRect.new()
	var button_texture: AtlasTexture =AtlasTexture.new()
	button_texture.atlas= style
	button_texture.region = region
	texture_container.texture=button_texture
	texture_container.custom_minimum_size=button_size
	texture_container.expand_mode=TextureRect.EXPAND_IGNORE_SIZE
	button.add_child(texture_container)
	return button
	
func loadButtons():
	var button_container= HBoxContainer.new()
	button_container.add_spacer(false)
	button_container.custom_minimum_size.y=button_size.y
	button_container.size_flags_horizontal=Control.SIZE_SHRINK_END
	
	var close = createButton(Rect2(550,90,90,90))
	close.connect("button_down", _on_close_input)
	
	var maximize_button:Button = createButton(Rect2(470,90,80,90))
	maximize_button.connect("button_down", _on_maximize_pressed)
	
	
	button_container.add_child(maximize_button)
	button_container.add_child(close)
	titleBar.add_child(button_container)
	
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

func _on_close_input():
	queue_free()

func _on_maximize_pressed():
	var tween= get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	if is_maximized:
		tween.parallel().tween_property(self,"size",prev_size,0.2)
		tween.parallel().tween_property(self,"position",prev_position,0.2)
	else:
		prev_size = size
		prev_position = position
		tween.parallel().tween_property(self,"size",get_parent().size,0.2)
		tween.parallel().tween_property(self,"position",Vector2(0,0),0.2)
	is_maximized = !is_maximized  # Toggle maximize state
