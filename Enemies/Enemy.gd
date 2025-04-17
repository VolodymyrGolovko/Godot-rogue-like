extends Node2D

class_name Enemy

@export var max_health: int
@export var current_health: int
@export var move_speed: int

@export var always_active: bool
@export var is_active: bool

var brain: EnemyBrain = EnemyBrain.new()
var current_state: EnemyState = null

func _ready():
	change_state(IdleState.new())

func change_state(new_state: EnemyState):
	if current_state:
		current_state.exit(self)
	current_state = new_state
	current_state.enter(self)

func _physics_process(delta):
	if current_state:
		current_state.update(self, delta)
	
	if current_state.is_finished():
		brain.update(self, delta)

func attack(): #should be defined in each Enemy child
	pass

func take_damage(amount: int):
	current_health -= amount
	if current_health <= 0:
		die()

func die():
	queue_free()
	
func interrupt_action():
	if current_state.is_interruptible():
		change_state(IdleState.new())

func projectile_collision_reaction(obj: BaseProjectile):
	take_damage(obj.character_damage)
	obj.character_collision_reaction()
	pass
