extends Node2D

const SCROLL_SPEED := 200.0
var tiles: Array[Sprite2D] = []

func _ready() -> void:
	# Collect only the Sprite2D children under FloorVisual
	for child in get_children():
		if child is Sprite2D:
			tiles.append(child)

func _process(delta: float) -> void:
	var tile_count := tiles.size()
	if tile_count == 0:
		return

	for tile in tiles:
		var width := tile.texture.get_size().x
		tile.position.x -= SCROLL_SPEED * delta

		# recycle when offscreen
		if tile.position.x <= -width:
			tile.position.x += width * tile_count
