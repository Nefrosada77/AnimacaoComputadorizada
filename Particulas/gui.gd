extends Control

@export var particle_simulator : ParticleSimulator
@export var size_box : PanelContainer
@export var height_box : PanelContainer
@export var radius_box : PanelContainer

func _on_on_off_toggled(toggled_on: bool) -> void:
	particle_simulator.emitting = toggled_on


func _on_max_particles_value_changed(value: int) -> void:
	particle_simulator.max_particles = value


func _on_spawn_size_value_changed(value: float, extra_arg_0: int) -> void:
	match extra_arg_0:
		0:
			particle_simulator.spawn_range.size.x = value
		1:
			particle_simulator.spawn_range.size.y = value
		2:
			particle_simulator.spawn_range.size.z = value


func _on_particle_life_value_changed(value: float) -> void:
	particle_simulator.particle_life_time = value


func _on_particle_random_value_changed(value: float) -> void:
	particle_simulator.life_time_randomness = value


func _on_particle_type_item_selected(index: int) -> void:
	match index:
		0:
			size_box.set_visible(true)
			height_box.set_visible(false)
			radius_box.set_visible(false)
		1:
			size_box.set_visible(false)
			height_box.set_visible(true)
			radius_box.set_visible(true)
	particle_simulator.particle_type = index as ParticleSimulator.particle_types

func _on_particle_size_value_changed(value: float, extra_arg_0: int) -> void:
	match extra_arg_0:
		0:
			particle_simulator.particle_size.x = value
		1:
			particle_simulator.particle_size.y = value
		2:
			particle_simulator.particle_size.z = value


func _on_sphere_particle_height_value_changed(value: float) -> void:
	particle_simulator.particle_height = value


func _on_sphere_particle_radius_value_changed(value: float) -> void:
	particle_simulator.particle_radius = value


func _on_start_color_changed(color: Color) -> void:
	particle_simulator.start_color = color


func _on_finish_color_changed(color: Color) -> void:
	particle_simulator.finish_color = color

func _on_rotation_value_changed(value: float, extra_arg_0: int) -> void:
	match extra_arg_0:
		0:
			particle_simulator.animation_rotation.x = value
		1:
			particle_simulator.animation_rotation.y = value
		2:
			particle_simulator.animation_rotation.z = value

func _on_position_value_changed(value: float, extra_arg_0: int) -> void:
	match extra_arg_0:
		0:
			particle_simulator.animation_position.x = value
		1:
			particle_simulator.animation_position.y = value
		2:
			particle_simulator.animation_position.z = value

func _on_scale_value_changed(value: float, extra_arg_0: int) -> void:
	match extra_arg_0:
		0:
			particle_simulator.animation_scale.x = value
		1:
			particle_simulator.animation_scale.y = value
		2:
			particle_simulator.animation_scale.z = value


func _on_animation_time_value_changed(value: float) -> void:
	particle_simulator.animation_timer = value


func _on_death_type_item_selected(index: int) -> void:
	particle_simulator.particle_death_type = index as ParticleSimulator.death_type
