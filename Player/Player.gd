extends KinematicBody2D

export var acceleration:float = 2160 setget set_acceleration, get_acceleration
export var impulse:float = 900 setget set_impulse, get_acceleration
export var deceleration:float = 540 setget set_acceleration, get_acceleration
export var max_speed:float = 360 setget set_max_speed, get_max_speed
export var turn_rate:float = 20 setget set_turn_rate, get_turn_rate

var velocity:Vector2 = Vector2(0, 0)

func _ready():
	pass # Replace with function body.

func _process(delta):
	$Smoke.rotation = randf() * 360
	$Bright.rotation = randf() * 360
	var _emit:bool = Input.is_action_pressed("player_accelerate")
	$Smoke.emitting = _emit
	$Bright.emitting = _emit

func _physics_process(delta):
	
	#turn logic
	var _target_position:Vector2 = get_global_mouse_position() - position
	var _target_rotation:float = atan2(_target_position.y, _target_position.x)
	var _rotation_difference:float = wrapf(_target_rotation - rotation, -PI, PI)
	rotate(_rotation_difference * delta * turn_rate)
	rotation = wrapf(rotation, 0, 2 * PI)
	
	#move logic
	if(Input.is_action_just_pressed("player_accelerate")): #impulse
		accelerate(impulse, rotation)
	if(Input.is_action_pressed("player_accelerate")): #accelerate
		accelerate(acceleration * delta, rotation)
	if(Input.is_action_pressed("player_decelerate")): #decelerate
		decelerate(deceleration * delta)
	
	#speed limit
	if(velocity.length() >= max_speed):
		velocity -= velocity.normalized() * delta * 3 * velocity.length()
	
	#move
	position += velocity * delta
	

#ship functions
func accelerate(_acceleration:float, _angle) -> void:
	#may need to simplify this for performance later
	var _acceleration_vector:Vector2 = Vector2(_acceleration, 0).rotated(rotation)
	velocity += _acceleration_vector

func decelerate(_deceleration:float) -> void:
	var _dec_actual:Vector2 = velocity.normalized() * min(_deceleration, velocity.length())
	velocity -= _dec_actual


#setters and getters
func set_acceleration(_acceleration:float) -> void: acceleration = _acceleration
func get_acceleration() -> float: return acceleration
func set_impulse(_impulse:float) -> void: impulse = _impulse
func get_impulse() -> float: return impulse
func set_deceleration(_deceleration:float) -> void: deceleration = _deceleration
func get_deceleration() -> float: return deceleration
func set_turn_rate(_turn_rate:float) -> void: turn_rate = _turn_rate
func get_turn_rate() -> float: return turn_rate
func set_max_speed(_max_speed:float) -> void: max_speed = _max_speed
func get_max_speed() -> float: return max_speed













