extends CharacterBody2D

@onready var move_cooldown: Timer = $MoveCooldownTimer

var may_move: bool = true

func _process(delta: float) -> void:
	if may_move:
		var direction = get_random_valid_direction()
		print(direction)
		get_node("Move4DComponent").move(direction)
		may_move = false
		move_cooldown.start()


#func is_captured():
	# Loop over possible directions to move in. 
	# If any valid move found, return FALSE. If no valid moves, return TRUE
	#for direction in MOVES.keys():
		#if is_valid_move(direction):
			#return false
	#return true


func get_random_valid_direction():
	# This function assumes there is at least one valid move, 
	# so don't call this if is_captured() returns TRUE
	
	# Shuffle all possible directions
	var directions: Array = get_node("Move4DComponent").MOVES.keys()
	directions.shuffle()

	# If the first direction is valid, return it. 
	# Else, remove it and check the new first direction
	for i in directions.size():
		if get_node("Move4DComponent").is_valid_move(directions[0]):
			return directions[0]
		directions.pop_front()


func _on_move_cooldown_timeout():
	may_move = true
