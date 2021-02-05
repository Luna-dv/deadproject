extends KinematicBody2D

export var follow_dist:float = 30
export var follow_rate:float = 30
export var turn_rate:float = 15
var target:Node

func _ready():
	target = get_node("../Player")

func _physics_process(delta):
	var rot:float = target.rotation
	var pos:Vector2 = target.position
	
	var p_dif = pos - position
	var target_rotation:float = atan2(p_dif.y, p_dif.x) - PI
	var rotation_difference = wrapf(target_rotation - rotation, -PI, PI)
	rotate(rotation_difference * turn_rate * delta)
	
	var target_position:Vector2 = pos + (Vector2(-follow_dist, 0).rotated(rot))
	var position_difference:Vector2 = target_position - position
	position += position_difference * follow_rate * delta

