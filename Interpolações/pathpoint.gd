extends PanelContainer
class_name PathPointContainer

@export var X_spin_box : SpinBox
@export var Y_spin_box : SpinBox
@export var Z_spin_box : SpinBox

var path : Path

func set_point_position(pos: Vector3):
	X_spin_box.value = pos.x
	Y_spin_box.value = pos.y
	Z_spin_box.value = pos.z

func disable_spin_box():
	X_spin_box.set_editable(false)
	Y_spin_box.set_editable(false)
	Z_spin_box.set_editable(false)
	$MarginContainer/HBoxContainer/Delete.set_disabled(true)

func enable_spin_box():
	X_spin_box.set_editable(true)
	Y_spin_box.set_editable(true)
	Z_spin_box.set_editable(true)
	$MarginContainer/HBoxContainer/Delete.set_disabled(false)
	
func show_delete():
	$MarginContainer/HBoxContainer/Delete.set_visible(true)

func delete_point():
	path.points[path.path_points_containers.get_children().find(self)].queue_free()
	path.points.pop_at(path.path_points_containers.get_children().find(self))
	queue_free()
	path.create_path()
	if path.points.size() <= 7:
		path.new_point_button.set_disabled(false)


func _on_value_changed(value: float) -> void:
	path.points[path.path_points_containers.get_children().find(self)].global_position = Vector3(X_spin_box.value, Y_spin_box.value, Z_spin_box.value)
	path.create_path()
