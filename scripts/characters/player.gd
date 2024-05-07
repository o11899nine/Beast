extends CharacterBody2D

@onready var move_cooldown: Timer = $MoveCooldownTimer

var may_move: bool = true

func _process(delta: float) -> void:
	if may_move:
		for direction in get_node("Move4DComponent").MOVES:
			if Input.is_action_pressed(direction):
				if get_node("Move4DComponent").is_valid_move(direction):
					get_node("Move4DComponent").move(direction)
					may_move = false
					move_cooldown.start()




func _on_move_cooldown_timeout() -> void:
	may_move = true
