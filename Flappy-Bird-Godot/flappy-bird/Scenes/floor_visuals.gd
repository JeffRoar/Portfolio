extends Node2D

# --- Tunables ---
const SCROLL_SPEED := 100.0  # pixels per second

func _ready() -> void:
	# Line up all floor tiles side-by-side automatically
	var x := 0.0
	for tile in get_children():
		if tile is Sprite2D:
			tile.position.x = x
			x += tile.texture.get_size().x

func _process(delta: float) -> void:
	for tile in get_children():
		if tile is Sprite2D:
			# Get the width of the tile's texture
			var tile_width: float = tile.texture.get_size().x

			# Move tile left
			tile.position.x -= SCROLL_SPEED * delta

			# Snap to nearest pixel to avoid flicker
			tile.position.x = round(tile.position.x)

			# If tile goes offscreen, recycle it to the right end
			if tile.position.x < -tile_width:
				var rightmost: float = get_rightmost_tile_x()
				tile.position.x = rightmost + tile_width

# --- Helper: Find the rightmost tile's x-position ---
func get_rightmost_tile_x() -> float:
	var max_x: float = -INF
	for tile in get_children():
		if tile is Sprite2D:
			max_x = max(max_x, tile.position.x)
	return max_x if max_x != -INF else 0.0
