extends Area3D
class_name InteractZone
@export_dir var message:String
var info

func _ready() -> void:
	var hitbox= CollisionShape3D.new()
	hitbox.shape=BoxShape3D
	#hitbox.shape.extends=self.shape.extends
	
	add_child(hitbox)

func interact():
	info=load(message).instantiate()
	add_sibling(info)

func remove():
	info.queue_free()
