extends Node

const GRID_SIZE = 16

const MOVES_4D = {
	"move_north": Vector2(0,-1),
	"move_south": Vector2(0,1),
	"move_west": Vector2(-1,0),
	"move_east": Vector2(1,0),
}

const MOVES_8D = {
	"move_north": Vector2(0,-1),
	"move_south": Vector2(0,1),
	"move_west": Vector2(-1,0),
	"move_east": Vector2(1,0),
	"move_north_east": Vector2(1,-1),
	"move_south_east": Vector2(1,1),
	"move_north_west": Vector2(-1,-1),
	"move_south_west": Vector2(-1,1),
}

