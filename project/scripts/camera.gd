extends Marker3D
var camera:Camera3D
var time=0
var current_objective:Marker3D
var running= false

func _ready() -> void:
	camera=get_node("Camera3D")

## Funni lambda function to avoid repeated if in while loop. Not necessary but cool
## Rip old ternary operator: a if boolean else b
func move_camera_to(curve_point:Vector3,there=self,reverse=false, look_object=null):
	current_objective=there
	if (!running):
		running = true
		if look_object==null:
			look_object=there
		var get_look_target
		if reverse:
			get_look_target = func(pos):
				var direction = (look_object.global_position - pos).normalized()
				return pos - direction
		else:
			get_look_target = func(pos):
				return look_object.global_position
		while (time<1):
			"""camera.look_at(get_look_target.call(camera.position))
			camera.global_position=adaptive_bezier(ease_in_out(time),current_objective.global_position,curve_point)
			"""
			var pos = adaptive_bezier(ease_in_out(time), current_objective.global_position, curve_point)
			camera.global_position = pos

			# Target look-at position
			var target_look_pos = get_look_target.call(pos)
			
			# Direction the camera should look towards
			var target_direction = (target_look_pos - pos).normalized()
			var current_basis = camera.global_transform.basis
			var target_basis = Basis().looking_at(target_direction, Vector3.UP)
			
			# Interpolate between current and target rotation using slerp
			var t = clamp(time * 2.0, 0.0, 1.0)  # speed up rotation a bit
			camera.global_transform.basis = current_basis.slerp(target_basis, t)
			time+=get_process_delta_time()
			await get_tree().process_frame
		time=0
		running =false
	else:
		time=0
		
		
func adaptive_bezier(t,there:Vector3,curve_point:Vector3):
	var q0=camera.global_position.lerp(curve_point,t)
	var q1=curve_point.lerp(there,t)
	var r=q0.lerp(q1,t)
	return r

func ease_in_out(t: float) -> float:
	return t * t *t*t* (3.0 - 2.0 * t)

"""func get_curve_point_with_steering(from: Vector3, to: Vector3) -> Vector3:
	var desired = (to - from).normalized()
	var space = get_world_3d().direct_space_state
	var result = space.intersect_ray(from, to, [camera])

	if result:
		var avoid_dir = (result.normal + Vector3.UP).normalized()
		return from.lerp(to, 0.5) + avoid_dir * 3.0
	else:
		return from.lerp(to, 0.5) + Vector3.UP * 2"""
