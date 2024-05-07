extends Node

@onready var parent = get_parent()

func _ready():
	print(parent.can_push)
