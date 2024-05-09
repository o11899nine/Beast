class_name AiInputComponent
extends Node

@export var actor: Node2D
@export var move_component: MoveComponent
@export var move_delay: float = 1
@export_enum("4D", "8D") var directions: String

var DIRECTIONS: Dictionary

var timer: Timer = Timer.new()
var may_move: bool = true



func _ready():
	if directions == "4D":
		DIRECTIONS = Globals.DIRECTIONS_4D
	elif directions == "8D":
		DIRECTIONS = Globals.DIRECTIONS_8D
	
	timer.wait_time = move_delay
	timer.timeout.connect(_on_timer_timeout)
	actor.add_child.call_deferred(timer)
	timer.autostart = true

	
func _process(delta):
	var velocity: Vector2 = get_random_valid_direction()
	if velocity == Vector2.ZERO:
		actor.queue_free()
	elif may_move:
		move_component.move_and_push(velocity)
		may_move = false


func _on_timer_timeout() -> void:
	may_move = true

	
func get_random_valid_direction() -> Vector2:
	# This function assumes there is at least one valid move, 
	# so don't call this if is_captured() returns TRUE
	
	# Shuffle all possible directions
	var possible_directions: Array = DIRECTIONS.values()
	possible_directions.shuffle()

	# If the first direction is valid, return it. 
	# Else, remove it and check the new first direction
	for i in possible_directions.size():
		if move_component.is_valid_move(possible_directions[0]):
			return possible_directions[0]
		possible_directions.pop_front()
		
	return Vector2.ZERO
