extends Label
var player
var player_is_in_cutscene:bool= false
func _ready() -> void:
	add_theme_color_override("font_outline_color",Color.BLACK)
	add_theme_constant_override("outline_size",4)
	self_modulate.a=0
	player=get_node("/root/world/player")
	Broadcast.connect("player_idle",appear);
	Broadcast.connect("player_moving",disappear)
	Broadcast.connect("player_cutscene_entered",func():player_is_in_cutscene=true;disappear())
	Broadcast.connect("player_cutscene_exited",func():player_is_in_cutscene=false)

func appear():
	if !player_is_in_cutscene:
		var tween =get_tree().create_tween()
		tween.tween_property(self,"self_modulate:a",1,0.5)

func disappear():
	var tween =get_tree().create_tween()
	tween.tween_property(self,"self_modulate:a",0,0.5) 
