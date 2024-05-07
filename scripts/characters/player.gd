extends CharacterBody2D

@onready var move_cooldown: Timer = $MoveCooldownTimer

var may_move: bool = true
const MOVES = Globals.MOVES_4D

@onready var move_actions = get_node("MoveActions")

func _process(delta: float) -> void:
	if may_move:
		for direction in MOVES:
			if Input.is_action_pressed(direction):
				if move_actions.is_valid_move(direction):
					move_actions.move(direction)
					may_move = false
					move_cooldown.start()




func _on_move_cooldown_timeout() -> void:
	may_move = true
