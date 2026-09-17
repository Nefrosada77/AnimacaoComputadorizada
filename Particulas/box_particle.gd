extends Particle
class_name Box_Particle
var size : Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	material_override = StandardMaterial3D.new()
	material_override.albedo_color = start_color
	if texture:
		material_override.albedo_texture = texture
	var tween := create_tween()
	tween.tween_property(material_override, "albedo_color", finish_color, animation_timer).set_ease(Tween.EASE_IN_OUT)
	mesh = BoxMesh.new()
	mesh.size = size
