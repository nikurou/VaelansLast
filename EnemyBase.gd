extends Base

class_name EnemyBase

export(int) var gold
export(Array, String, FILE, '*.tscn') var units
export(int) var numberSpawned
export(float) var spawnTime

var _spawnTimer = 0

func _ready():
	add_to_group(Level.ENEMY_GROUP)
	add_to_group(Level.ENEMY_BASE_GROUP)

func die():
	level.playerGold += gold
	gold = 0
	.die()
	 
func _process(delta: float) -> void:
	delta *= level.gameSpeed
	_spawnTimer += delta
	if _spawnTimer >= spawnTime:
		_spawnTimer = 0
		for x in range(numberSpawned):
			var unit = units[randi() % len(units)]
			spawn(unit, Vector2(24 * randf(), 24 * randf()))
			
func spawn(unitScene, spawnOffset):
	var unit = level.spawn(unitScene)
	unit.position = self.position + spawnOffset