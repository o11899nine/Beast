class_name MoveInputComponent
extends Node

@export var move_component: MoveComponent
@onready var MOVES = Globals.MOVES_4D

func _process(delta):
	if Input.is_action_pressed("move_up"):
		move_component.move(Vector2.UP)
	if Input.is_action_pressed("move_down"):
		move_component.move(Vector2.DOWN)
	if Input.is_action_pressed("move_left"):
		move_component.move(Vector2.LEFT)
	if Input.is_action_pressed("move_right"):
		move_component.move(Vector2.RIGHT)
