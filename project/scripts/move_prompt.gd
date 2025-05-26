extends Label
var player
var player_is_in_cutscene:bool= false
func _ready() -> void:
	self_modulate.a=0
	player=get_node("/root/world/player")
	Broadcast.connect("player_idle",appear);Broadcast.connect("player_moving",disappear)
	Broadcast.player_cutscene_entered.connect(func():player_is_in_cutscene=true)
	Broadcast.connect("player_cutscene_exited",func():player_is_in_cutscene=false)

func appear():
	if !player_is_in_cutscene:
		var tween =get_tree().create_tween()
		tween.tween_property(self,"self_modulate:a",1,0.5)

func disappear():
	var tween =get_tree().create_tween()
	tween.tween_property(self,"self_modulate:a",0,0.5) 
