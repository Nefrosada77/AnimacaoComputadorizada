extends Node3D

@onready var animation_states: AnimationTree = $AuxScene/AnimationStates
@onready var animation_player: AnimationPlayer = $AuxScene/AnimationPlayer
@onready var state_label: Label = $PanelContainer/VBoxContainer/STATE_LABEL



func _physics_process(_delta: float) -> void:
	handle_animations()
	

func handle_animations():
	if Input.is_action_just_pressed("ui_up"):
		animation_states["parameters/conditions/jump"] = true
		await get_tree().create_timer(0.25).timeout
		animation_states["parameters/conditions/jump"] = false
	if Input.is_action_just_pressed("ui_down"):
		animation_states["parameters/conditions/hit"] = true
		await get_tree().create_timer(0.25).timeout
		animation_states["parameters/conditions/hit"] = false
	if Input.is_action_just_pressed("ui_left"):
		animation_states["parameters/conditions/kick"] = true
		await get_tree().create_timer(0.25).timeout
		animation_states["parameters/conditions/kick"] = false
	if Input.is_action_just_pressed("ui_right"):
		animation_states["parameters/conditions/punch"] = true
		await get_tree().create_timer(0.25).timeout
		animation_states["parameters/conditions/punch"] = false

func _on_animation_states_animation_started(anim_name: StringName) -> void:
	state_label.text = anim_name


func _on_animation_states_animation_finished(_anim_name: StringName) -> void:
	state_label.text = "FightingIdle"
