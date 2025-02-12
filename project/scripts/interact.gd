extends Area3D
class_name InteractZone
@export_file("*.tscn") var message:String
var info

func _ready() -> void:
	var hitbox= CollisionShape3D.new()
	hitbox.shape=BoxShape3D.new()
	add_child(hitbox)

func interact():
	info= load(message).instantiate()
	add_child(info)

func remove():
	info.queue_free()
