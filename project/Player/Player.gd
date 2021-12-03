extends KinematicBody2D

export var w_speed = 4.0

const TILE = 16

onready var anim_tree = $AnimationTree
onready var state = anim_tree.get("parameters/playback")
onready var ray = $RayCast2D
var camera = null

var init_pos = Vector2.ZERO
var input_direction = Vector2.ZERO
var is_move = false
var move_amt = 0.0


func _ready():
	init_pos = position

func _physics_process(delta):
	pause()
	if ray.is_colliding():
		var target = ray.get_collider()
		kill(target)
	if is_move == false:
		player_input()
	elif input_direction != Vector2.ZERO:
		state.travel("Walk")
		move(delta)
	else:
		state.travel("Idle")
		is_move = false
		
func player_input():
	if input_direction.y == 0:
		input_direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	if input_direction.x == 0:
		input_direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
		
	if input_direction != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", input_direction)
		anim_tree.set("parameters/Walk/blend_position", input_direction)
		init_pos = position
		is_move = true
	else:
		state.travel("Idle")

func pause():
	if Input.is_action_pressed("pause"):
		get_tree().change_scene("res://Menu/PMenu.tscn")

func kill(body):
	if Input.is_action_pressed("Kill"):
		if body.is_in_group("Red"):
			get_tree().change_scene("res://Menu/Win.tscn")
		elif body.is_in_group("Blue"):
			get_tree().change_scene("res://Menu/Lose.tscn")

func move(delta):
	move_amt += w_speed * delta
	var next_tile: Vector2 = input_direction * TILE / 2
	ray.cast_to = next_tile
	ray.force_raycast_update()
	if !ray.is_colliding():
		if move_amt >= 1.0:
			position = init_pos + (TILE  * input_direction)
			move_amt = 0.0
			is_move = false
		else:
			 position = init_pos + (TILE  * input_direction * move_amt)
	else:
		var exeption = ray.get_collider()
		if exeption.is_in_group("npc"):
			if move_amt >= 1.0:
				position = init_pos + (TILE  * input_direction)
				move_amt = 0.0
				is_move = false
			else:
				 position = init_pos + (TILE  * input_direction * move_amt)
		else:
			is_move = false
