extends Node3D
class_name ParticleSimulator

enum death_type {TIME, ANIMATION}
enum particle_types {BOX, SPHERE}

@export var emitting : bool = true
@export_range(1,100) var max_particles : int = 8 #Number os max particles at the same time
@export var particle_life_time : float = 1.0
@export_range(.0,1,0.01) var life_time_randomness : float = 0
@export var spawn_range : BoxMesh
@export var particle_type : particle_types
@export var start_color : Color = Color(1,1,1)
@export var finish_color : Color = Color(1,1,1)
@export var particle_size : Vector3 = Vector3(1,1,1)
@export var particle_height : float = 1.0
@export var particle_radius : float = 0.5
@export var particle_texture : Texture
@export var animation_rotation : Vector3
@export var animation_position : Vector3
@export var animation_scale : Vector3
@export var animation_timer : float = 1.0
@export var particle_death_type : death_type


var update_time: float = .0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if emitting:
		if get_child_count() < max_particles:
			if particle_type == particle_types.BOX:
				var new_particle := Box_Particle.new()
				pass_parameters(new_particle)
				add_child(new_particle)
			if particle_type == particle_types.SPHERE:
				var new_particle := Sphere_Particle.new()
				pass_parameters(new_particle)
				add_child(new_particle)

func pass_parameters(particle : Particle)-> void:
	particle.life_time = particle_life_time + randf_range(-particle_life_time * life_time_randomness, particle_life_time * life_time_randomness)
	particle.texture = particle_texture
	particle.spawn_position = global_position + Vector3(randf_range(-spawn_range.size.x, spawn_range.size.x), 
														 randf_range(-spawn_range.size.y, spawn_range.size.y), 
														 randf_range(-spawn_range.size.z, spawn_range.size.z))
	if particle is Box_Particle:
		particle.size = particle_size
	if particle is Sphere_Particle:
		particle.height = particle_height
		particle.radius = particle_radius
	particle.start_color = start_color
	particle.finish_color = finish_color
	particle.animation_timer = animation_timer
	particle.animation_rotation = animation_rotation
	particle.animation_position = animation_position
	particle.animation_scale = animation_scale
	if particle_death_type == death_type.TIME:
		particle.time_death = true
	else:
		particle.time_death = false
	if particle_death_type == death_type.ANIMATION:
		particle.animation_death = true
	else:
		particle.animation_death = false
