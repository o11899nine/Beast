extends Node2D

@onready var parent = get_parent()

func push(node: Node, direction: String) -> void:
	if node.has_node("IsPushable") and node.has_node("MoveActions"):
			node.get_node("MoveActions").move(direction)
