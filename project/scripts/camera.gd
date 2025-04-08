extends Marker3D
var camera:Camera3D
var time=0

func _ready() -> void:
	camera=get_node("Camera3D")
	

func move_camera_to(curve_point:Vector3,there=self, rot:Vector3=global_rotation_degrees):
	var tween=get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(camera,"global_rotation_degrees",rot,1)
	if there is Node3D:
		move_to_node(there,curve_point)
	elif there is Vector3:
		move_to_vector(there,curve_point)
	time=0

func move_to_node(there,curve_point):
	while (time<1):
		camera.global_position=adaptive_bezier(time,there.global_position,curve_point)
		print(there.global_positiond)
		time+=get_process_delta_time()
		await get_tree().process_frame
	
func move_to_vector(there,curve_point):
	while (time<1):
		camera.global_position=adaptive_bezier(time,there,curve_point)
		time+=get_process_delta_time()
		await get_tree().process_frame

func adaptive_bezier(t,there:Vector3,curve_point:Vector3):
	var q0=camera.global_position.lerp(curve_point,t)
	var q1=curve_point.lerp(there,t)
	var r=q0.lerp(q1,t)
	return r
