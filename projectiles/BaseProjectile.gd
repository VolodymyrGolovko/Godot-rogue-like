extends Area2D

class_name BaseProjectile

# Properties
@export var can_collide_allied: bool
@export var can_collide_hostile: bool
@export var is_grounded: bool #false = is aerial
@export var is_breakable: bool
@export var can_bounce: bool
@export var can_pierce: bool

@export var character_damage: int = 0
@export var obstacle_damage: int = 0
@export var pierces: int = 0
@export var bounces: int = 0
@export var travelled_distance: int = 0

@export var SPEED: int = 0
@export var RANGE: int = 0

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	
	position += direction * SPEED * delta
	travelled_distance += SPEED * delta
	
	if travelled_distance > RANGE:
		destroy()

func _on_body_entered(body: Node2D):
	if body is GameObject:
		if is_grounded and not body.passable_for_grounded:
			body.collide_grounded(self)
		if not is_grounded and not body.passable_for_aerial:
			body.collide_aerial(self)
	elif body is CharacterBody2D:
		if (can_collide_allied and body is Player) or (can_collide_hostile and body is Enemy):
			body.projectile_collision_reaction(self)
	pass

func obstacle_collision_reaction():
	if can_bounce and (bounces > 0):
		bounces -= 1
		bounce()
	else:
		destroy()

func character_collision_reaction():
	if can_pierce and (pierces > 0):
		pierces -= 1
		pierce()
	else:
		destroy()

func pierce(): #заповнити функцію, може
	pass

func bounce(): #заповнити функцію, може
	pass

func destroy():
	queue_free()
