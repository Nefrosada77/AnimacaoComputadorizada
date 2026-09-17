extends Particle
class_name Sphere_Particle
var radius : float
var height : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	material_override = StandardMaterial3D.new()
	material_override.albedo_color = start_color
	if texture:
		material_override.albedo_texture = texture
	var tween := create_tween()
	tween.tween_property(material_override, "albedo_color", finish_color, animation_timer).set_ease(Tween.EASE_IN_OUT)
	mesh = SphereMesh.new()
	mesh.height = height
	mesh.radius = radius
