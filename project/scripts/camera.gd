extends Marker3D

func _ready() -> void:
	pass

func move_to(there:Vector3, rot:Vector3):
	#var tween:Tween
	#tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	#tween.tween_property(self)
	position=there
	rotation_degrees=rot
	
