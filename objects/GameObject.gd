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


# Functions
func _ready():
	if can_be_destroyed:
		current_health = max_health

func collide_grounded(obj: Object):
	if passable_for_grounded:
		pass
	else:
		if can_be_destroyed:
			take_damage(obj.damage)
		reaction_to_grounded(obj)

func collide_aerial(obj: Object):
	if passable_for_aerial:
		pass
	else:
		if can_be_destroyed:
			take_damage(obj.damage)
		reaction_to_aerial(obj)

func take_damage(amount: int):
	if can_be_destroyed:
		current_health -= amount
		if current_health <= 0:
			destroy()

func apply_effect(effect_name: String, duration: float):
	if affectable:
		effects[effect_name] = duration


# Conditional functions
func reaction_to_grounded(obj: Object):
	obj.destroy() #знищити об'єкт що колізію робить, замінити в майбутньому
	pass

func reaction_to_aerial(obj: Object):
	obj.destroy() #знищити об'єкт що колізію робить, замінити в майбутньому
	pass

func destroy():
	queue_free() #знищити об'єкт, замінити в майбутньому
	pass
