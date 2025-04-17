extends StaticBody2D

class_name GameObject

# Properties
@export var is_walkable: bool
@export var passable_for_grounded: bool
@export var passable_for_aerial: bool
@export var is_moveable: bool
@export var can_be_destroyed: bool
@export var affectable: bool


# Conditional properties
@export var max_health: int = 0
@export var current_health: int = 0
@export var effects: Dictionary = {}
var velocity: Vector2 = Vector2.ZERO


# Functions
func _ready():
	if can_be_destroyed:
		current_health = max_health

func apply_force(force: Vector2):
	if is_moveable:
		velocity += force

func collide_grounded(obj: Object):
	if can_be_destroyed:
		take_damage(obj.obstacle_damage)
	reaction_to_grounded(obj)

func collide_aerial(obj: Object):
	if can_be_destroyed:
		take_damage(obj.obstacle_damage)
	reaction_to_aerial(obj)

func take_damage(amount: int):
	print(current_health)
	print(amount)
	if can_be_destroyed:
		current_health -= amount
		if current_health <= 0:
			destroy()

func apply_effect(effect_name: String, duration: float):
	if affectable:
		effects[effect_name] = duration


# Conditional functions
func reaction_to_grounded(obj: Object):
	if obj is BaseProjectile:
		obj.obstacle_collision_reaction()
	pass

func reaction_to_aerial(obj: Object):
	if obj is BaseProjectile:
		obj.obstacle_collision_reaction()
	pass

func destroy():
	queue_free() #знищити об'єкт, замінити в майбутньому
	pass
