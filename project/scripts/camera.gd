extends Marker3D
var camera:Camera3D
var player:CharacterBody3D
var time=0
var current_objective:Marker3D
var current_look_objective:Node3D
var current_rot
var running= false

func _ready() -> void:
	player=get_node("..")
	camera=get_node("Camera3D")
	current_rot = camera.global_transform.basis

## Nodes are pointers, will update live in function
func move_camera_to(curve_point:Vector3,there=self,reverse=false,look_there=player):
	update_objectives(there,look_there)
	if (!running):
		running = true
		while (time<1):
			var pos = adaptive_bezier(ease_in_out(time), current_objective.global_position, curve_point)
			camera.global_position = pos
			
			time+=get_process_delta_time()
			await get_tree().process_frame
		time=0
		running =false
	else:
		time=0
func find_c_from_a_direction(a_transform: Transform3D, b: Vector3) -> Vector3:
	# Use a's local forward direction — change to .x or .z depending on your setup
	var ac_direction = a_transform.basis.x.normalized()

	# Make sure everything is on the same height as b
	var a_pos = a_transform.origin
	var a_proj = Vector3(a_pos.x, b.y, a_pos.z)
	var b_proj = Vector3(b.x, b.y, b.z)

	# Vector from a to b, in the XZ plane
	var ab = b_proj - a_proj

	# Project ab onto ac_direction
	var proj_length = ab.dot(ac_direction)
	var proj_vector = ac_direction * proj_length

	# Compute c such that a→c is along a's direction, and perpendicular to b→c
	var c_proj = a_proj + proj_vector
	var c = Vector3(c_proj.x, b.y, c_proj.z)
	return c

## args cam_pos, look_rotation
func update_objectives(objective=current_objective,look_objective=current_look_objective):
	current_objective=objective
	current_look_objective=look_objective

func get_rotation_look_at(target_position: Vector3):
	var current_rotation = camera.global_transform.basis.get_rotation_quaternion()

	var direction = (target_position - camera.global_transform.origin).normalized()
	var target_basis = Basis.looking_at(direction)
	var target_rotation = target_basis.get_rotation_quaternion()
	return target_rotation


func adaptive_bezier(t,there:Vector3,curve_point:Vector3):
	var q0=camera.global_position.lerp(curve_point,t)
	var q1=curve_point.lerp(there,t)
	var r=q0.lerp(q1,t)
	return r

func ease_in_out(t: float) -> float:
	return pow(t,4)* (3.0 - 2.0 * t)
