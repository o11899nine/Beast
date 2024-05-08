class_name MoveInputComponent
extends Node

@export var move_component: MoveComponent

const MOVES = Globals.MOVES_4D

var has_moved: bool = false

func _process(delta):
	for direction in MOVES:
			if Input.is_action_pressed(direction):
				move_component.move(MOVES[direction])
				has_moved = true
	
	if has_moved:
		move_component.may_move = false
