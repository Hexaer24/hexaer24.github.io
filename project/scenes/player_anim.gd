extends AnimationPlayer

func _ready() -> void:
	var anims=[get_animation("impatience"),get_animation("run"),get_animation("idle")]
	for anim in anims:
		for i in anim.get_track_count():
			anim.track_set_interpolation_type(i, Animation.INTERPOLATION_NEAREST)
