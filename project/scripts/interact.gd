class_name InteractZone extends Area3D
@export_file("*.tscn") var message:String
@export_node_path()

var info
var global_camera:Node
var player_camera

func _ready() -> void:
	global_camera=get_node("../CameraRig")
	player_camera=get_node("../player/Camera3D")
	
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	var hitbox= CollisionShape3D.new()
	hitbox.shape=BoxShape3D.new()
	add_child(hitbox)

func interact():
	global_camera.move_to(Vector3(-1.1,1.3,-1.1,), Vector3(0,45,0), func (tween:Tween):
		tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO))


func _on_body_entered(body) -> void:
	if (body is CharacterBody3D):
		global_camera.get_child(0).current=true
		interact()


func _on_body_exited(body) -> void:
	if (body is CharacterBody3D):
		player_camera.current=true
