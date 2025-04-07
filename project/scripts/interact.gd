class_name InteractZone extends Area3D
@export_file("*.tscn") var message:String
@export_node_path()

var info
var not_camera

func _ready() -> void:
	not_camera=get_node("../player/Marker3D")
	
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	var hitbox= CollisionShape3D.new()
	hitbox.shape=BoxShape3D.new()
	add_child(hitbox)

func interact():
	not_camera.move_camera_to( Vector3(0,1,0),Vector3(-1.1,1.3,-1.1,), Vector3(0,45,0))


func _on_body_entered(body) -> void:
	if (body is CharacterBody3D):
		print(not_camera.position,not_camera.get_child(0).position)
		interact()


func _on_body_exited(body) -> void:
	not_camera.move_camera_to(Vector3(0,1,0))
	print(not_camera.position,not_camera.get_child(0).position)
