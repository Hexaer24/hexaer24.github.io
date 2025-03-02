extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var size = get_aabb().size
	var size2 = Vector2(size.x,size.y)
	$SubViewport/os/Desktop.size=size2
	$SubViewport.size=size2*1000
	var shader_material = material_override
	print($SubViewport/os/Desktop.size,$SubViewport.size)


func _process(delta: float) -> void:
	pass
