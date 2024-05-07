extends Node2D

@onready var parent = get_parent()

func push(node: Node, direction: String) -> void:
	if node.has_node("PushableComponent") and node.has_node("Move4DComponent"):
			node.get_node("Move4DComponent").move(direction)
