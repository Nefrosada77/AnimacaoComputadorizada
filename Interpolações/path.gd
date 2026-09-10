extends Node
class_name Path

enum path_type {linear, bezier}

@onready var path_3d: Path3D = $"../Path3D"
@onready var timer_count: Timer = $"../Timer"
@onready var timer_label: Label = $"../MarginContainer/Timer_Label"
@export var point_scene : PackedScene
@export var key_point_scene : PackedScene
@export var path_container_scene : PackedScene
@export var interpolation : path_type
@export var points : Array[Marker3D]
@export var path_points_containers : VBoxContainer
@export var player : CharacterBody3D
@export var timer : int = 1
@export var new_point_button : Button
@export_range(1,60) var number_of_points : int = 10

var path_follow : PathFollow3D

func _ready() -> void:
	%Timer.value = timer
	%NumPoints.value = number_of_points
	create_path()
	for i in range(len(points)):
		var new_container : PathPointContainer = path_container_scene.instantiate()
		new_container.path = self
		new_container.set_point_position(points[i].global_position)
		path_points_containers.add_child(new_container)
		path_points_containers.move_child(new_point_button, path_points_containers.get_child_count()-1)
		if i > 1:
			new_container.show_delete()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func create_path() -> void:
	for child in get_children():
		child.queue_free()
	path_3d.curve.clear_points()
	if interpolation == path_type.linear:
		for point in points:
			path_3d.curve.add_point(point.global_position)
			if point != points[len(points)-1]:
				var t := .0
				for i in range(0,number_of_points):
					t += (1.0/(number_of_points+1))
					create_point(point.global_position.lerp(points[points.find(point)+1].global_position,t))
			
	elif interpolation == path_type.bezier:
		var t := .0
		path_3d.curve.add_point(points[0].global_position)
		for i in range(0, number_of_points):
			t += (1.0/(number_of_points+1))
			var points_array : Array[Vector3] = []
			var target := len(points)-1
			var dir := 0
			for point in points:
				points_array.append(point.global_position)
			while points_array.size() > 1:
				points_array.append(points_array[0].lerp(points_array[1], t))
				points_array.pop_front()
				dir += 1
				if dir == target:
					points_array.pop_front()
					target -= 1
					dir = 0
			create_point(points_array[0])
		path_3d.curve.add_point(points[len(points)-1].global_position)


func create_point(position : Vector3) -> Vector3:
	var new_point := point_scene.instantiate()
	add_child(new_point)
	new_point.global_position = position
	path_3d.curve.add_point(position)
	return position

func _physics_process(_delta: float) -> void:
	timer_label.text = str(timer_count.time_left)

func _on_button_pressed() -> void:
	timer_count.wait_time = timer
	disableGUI()
	for child in path_points_containers.get_children():
		if child is PathPointContainer:
			child.disable_spin_box()
	create_path()
	
	for idx in range(path_3d.curve.point_count):
		player.global_position = path_3d.curve.get_point_position(idx)
		if interpolation == path_type.linear:
			await get_tree().create_timer(float(timer) / ((float(number_of_points) * (len(points)-1))+3)).timeout
		elif interpolation == path_type.bezier:
			await get_tree().create_timer(float(timer) / (float(number_of_points)+2)).timeout

	enableGUI()
	for child in path_points_containers.get_children():
		if child is PathPointContainer:
			child.enable_spin_box()

func _on_new_point_pressed() -> void:
	var new_container : PathPointContainer = path_container_scene.instantiate()
	var new_point := key_point_scene.instantiate()
	%PathPoints.add_child(new_point)
	new_container.path = self
	points.append(new_point)
	new_container.set_point_position(new_point.global_position)
	path_points_containers.add_child(new_container)
	path_points_containers.move_child(new_point_button, path_points_containers.get_child_count()-1)
	new_container.show_delete()
	if len(points) >= 8:
		new_point_button.set_disabled(true)
	create_path()


func _on_timer_value_changed(value: float) -> void:
	timer = int(value)

func _on_num_points_value_changed(value: float) -> void:
	number_of_points = int(value)
	create_path()

func _on_option_button_item_selected(index: int) -> void:
	interpolation = index
	create_path()

func disableGUI():
	%Timer.editable = false
	%NumPoints.editable = false
	%OptionButton.set_disabled(true)
	%START.set_disabled(true)
	new_point_button.set_disabled(true)

func enableGUI():
	%Timer.editable = true
	%NumPoints.editable = true
	%OptionButton.set_disabled(false)
	%START.set_disabled(false)
	new_point_button.set_disabled(false)
