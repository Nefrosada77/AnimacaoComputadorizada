extends MeshInstance3D
class_name Particle

var life_time : float = 1.0 #Seconds that the particle will live
var time_death : bool = false
var parent : ParticleSimulator
var texture : Texture
var spawn_position : Vector3
var start_color : Color
var finish_color : Color
var animation_death : bool = false
var sprite_sheet_h : int
var sprite_sheet_v : int
var sprite_frames : int
var animation_finished_death : bool = false
var animation_timer : float
var animation_rotation : Vector3
var animation_position : Vector3
var animation_scale : Vector3
var position_death : bool = false

var curr_life : float = 0.0

func _ready() -> void:
	global_position = spawn_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	curr_life += delta
	rotation += animation_rotation * delta
	position += animation_position * delta
	scale += animation_scale * delta
	if time_death:
		if curr_life <= life_time:
			return
	if animation_death:
		if curr_life <= animation_timer:
			return
	queue_free()
