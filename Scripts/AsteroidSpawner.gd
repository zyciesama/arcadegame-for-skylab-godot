extends Node2D

@export var asteroid_scene: PackedScene
@export var spawn_interval: float = 2.0
var timer: float = 0.0
var game: Node  # Oyun sahnesine referans


func _ready() -> void:
	var current_scene = get_tree().current_scene
	if current_scene:
		print("Current scene: ", current_scene.name)
		game = current_scene  # Geçerli sahneye atama yap
	else:
		print("No current scene found.")


func _process(delta: float) -> void:
	timer += delta
	if timer >= spawn_interval:
		spawn_asteroid()
		timer = 0.0

func spawn_asteroid() -> void:
	var asteroid = asteroid_scene.instantiate()
	asteroid.size = Asteroid.AsteroidSize.LARGE
	asteroid.connect("exploded", Callable(self, "_on_asteroid_exploded"))

	# Ekranın kenarlarından spawn için:
	var edge = randf_range(0, 4)
	var random_x: float
	var random_y: float
	
	match edge:
		0:  # Üst kenar
			random_x = randf_range(0, 1920)  # 0 ile 1920 arasında
			random_y = 0  # Üst kenar
		1:  # Alt kenar
			random_x = randf_range(0, 1920)
			random_y = 1080  # Alt kenar
		2:  # Sol kenar
			random_x = 0  # Sol kenar
			random_y = randf_range(0, 1080)
		3:  # Sağ kenar
			random_x = 1920  # Sağ kenar
			random_y = randf_range(0, 1080)

	# Debug: Konumu yazdır
	print("Asteroid spawned at: ", random_x, ", ", random_y)
	asteroid.position = Vector2(random_x, random_y)
	add_child(asteroid)

func _on_asteroid_exploded(pos, size, points):
	# Game'deki patlama fonksiyonunu çağır
	game._on_asteroid_exploded(pos, size, points)
