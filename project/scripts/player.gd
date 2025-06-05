extends CharacterBody3D
const SPEED = 5.0
var is_idle:bool=true
enum States{NONE,IDLE,MOVING}
@onready var timer_idle=$Timer
@onready var anim=$player_model/AnimationPlayer
@onready var model = $player_model
var is_in_zone:bool=false
var is_in_cutscene:bool=false
var state:States= States.NONE:
	set=set_state

func set_state(new_state):
	if new_state==state:
		return
	var previous_state:=state
	state=new_state
	if state==States.IDLE:
		anim.play("idle")
		timer_idle.start(5)
	if state==States.MOVING:
		timer_idle.stop()
		anim.play("run")
		Broadcast.emit_signal("player_moving")

func _ready() -> void:
	var main_focus=$"../room/Cylinder/InteractZone"
	if OS.has_feature("web_android") or OS.has_feature("web_ios"):
		get_tree().change_scene_to_file("res://scenes/os.tscn")

func in_zone(zone:InteractZone):
	while is_in_zone:
		if Input.is_action_just_pressed("interact"):
			zone.cam_move(self)
		if Input.is_action_just_pressed("cancel"):
			if is_in_cutscene:
				zone.cam_move(self)
		await get_tree().process_frame

func _physics_process(_delta: float) -> void:
	var input_dir := Input.get_vector("left", "right", "up", "down")
	state=States.IDLE if input_dir.is_zero_approx() else States.MOVING
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and state in [States.IDLE,States.MOVING]:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	if state==States.MOVING:
		model.rotation.y = atan2(velocity.x,velocity.z)
	move_and_slide()
func _on_timer_timeout() -> void:
	Broadcast.emit_signal("player_idle")
	anim.play("impatience")
