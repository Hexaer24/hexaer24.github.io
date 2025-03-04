extends Marker3D

@export var screen_area: NodePath = "../room/Cube_002/Area3D"# Assign the 3D screen MeshInstance3D
@export var viewport: NodePath ="../room/Cube_002/SubViewport" # Assign the Viewport node
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func move_to(there:Vector3, rot:Vector3):
	position=there
	rotation_degrees=rot
	
func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		var space_state = get_world_3d().direct_space_state
		var mouse_pos = get_viewport().get_mouse_position()
		var from = $Camera3D.project_ray_origin(mouse_pos)
		var to = from + $Camera3D.project_ray_normal(mouse_pos) * 100  # Cast the ray forward
		
		var query = PhysicsRayQueryParameters3D.create(from, to)
		var result = space_state.intersect_ray(query)
		if result and result.collider == get_node(screen_area):
			var mesh=result.collider.get_parent().mesh as ArrayMesh
			var surface_tool = SurfaceTool.new()
			var surface_array = mesh.surface_get_arrays(0) # Get first surface
			var vertex_array = surface_array[Mesh.ARRAY_VERTEX]
			var uv_array = surface_array[Mesh.ARRAY_TEX_UV]
			var face_index = result["face_index"]
			var uv1 = uv_array[face_index]
			var uv2 = uv_array[face_index + 1]
			var uv3 = uv_array[face_index + 2]
			var hit_point = result.position
			var v1 = vertex_array[face_index]
			var v2 = vertex_array[face_index + 1]
			var v3 = vertex_array[face_index + 2]
			var barycentric = get_barycentric_coords(hit_point, v1, v2, v3)
			var hit_uv = (uv1 * barycentric.x) + (uv2 * barycentric.y) + (uv3 * barycentric.z)
			var vp = get_node(viewport) as SubViewport
			var screen_pos = hit_uv * Vector2(vp.size)
			var click_event = event.duplicate()
			click_event.position = screen_pos  # Set position inside the SubViewport
			vp.push_input(click_event)

			print("Click sent at:", screen_pos)
			#var vp = get_node(viewport)
			
			# Convert 3D hit to 2D UV coordinates
			#var uv = result.collider.get_parent().uv * vp.size  # Scale UV to viewport resolution

			# Create a new click event at the correct position
			#var click_event = event.duplicate()
			#click_event.position = uv

			# Send the input event to the Viewport
			#vp.push_input(click_event)

func get_barycentric_coords(p, a, b, c):
	var v0 = b - a
	var v1 = c - a
	var v2 = p - a
	var d00 = v0.dot(v0)
	var d01 = v0.dot(v1)
	var d11 = v1.dot(v1)
	var d20 = v2.dot(v0)
	var d21 = v2.dot(v1)
	var denom = d00 * d11 - d01 * d01
	var v = (d11 * d20 - d01 * d21) / denom
	var w = (d00 * d21 - d01 * d20) / denom
	var u = 1.0 - v - w
	return Vector3(u, v, w)
