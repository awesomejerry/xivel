extends PathFollow2D

var enemy_type := "":
	set(val):
		enemy_type = val
		$Sprite2D.texture = load(Data.enemies[val]["sprite"])
		for stat in Data.enemies[val]["stats"].keys():
			set(stat, Data.enemies[val]["stats"][stat])

enum State {walking, damaged}
var state = State.walking
var goldYield := 10.0
var hp := 10.0
var baseDamage := 5.0
var speed := 1.0
var is_destroyed := false

var last_location = Vector2.ZERO

@onready var spawner := get_parent() as EnemyPath
func _ready():
	add_to_group("enemy")

func _process(_delta):
	if state == State.walking:
		#Move
		progress_ratio += 0.0005 * speed
		if progress_ratio == 1:
			finished_path()
			return
		#Flip
		$Sprite2D.flip_h = last_location.x > position.x
		last_location = position
		# var angle = int(rotation_degrees) % 360
		# if angle > 180:
		# 	angle -= 360
		# $Sprite2D.flip_v = abs(angle) > 90

func finished_path():
	if is_destroyed:
		return
	is_destroyed = true
	spawner.enemy_destroyed()
	Globals.currentMap.get_base_damage(baseDamage)
	queue_free()

func get_damage(damage):
	if is_destroyed:
		return
	hp -= damage
	damage_animation()
	if hp <= 0:
		$Dead.play()
		is_destroyed = true
		spawner.enemy_destroyed()
		Globals.currentMap.gold += goldYield
		await get_tree().create_timer(0.6).timeout
		queue_free()

func damage_animation():
	var tween := create_tween()
	tween.tween_property(self, "v_offset", 0, 0.05)
	tween.tween_property(self, "modulate", Color.ORANGE_RED, 0.1)
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)
	tween.set_parallel()
	tween.tween_property(self, "v_offset", -5, 0.2)
	tween.set_parallel(false)
	tween.tween_property(self, "v_offset", 0, 0.2)
