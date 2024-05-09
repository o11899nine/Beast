class_name MoveInputComponent
extends Node

@export var actor: Node2D
@export var move_component: MoveComponent
@export var move_delay: float = 1

const DIRECTIONS = Globals.DIRECTIONS_4D
	
var timer: Timer = Timer.new()
var may_move: bool = true


func _ready():
	timer.wait_time = move_delay
	timer.timeout.connect(_on_timer_timeout)
	actor.add_child.call_deferred(timer)
	timer.autostart = true

	
func _process(delta):
	if may_move:
		var velocity: Vector2 = Vector2.ZERO
		for direction in DIRECTIONS:
				if Input.is_action_pressed(direction):
					velocity += DIRECTIONS[direction]
		if velocity != Vector2.ZERO:
			if move_component.is_valid_move(velocity):
				move_component.move_and_push(velocity)
				may_move = false


func _on_timer_timeout() -> void:
	may_move = true
