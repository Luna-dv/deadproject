extends Camera2D

var target:Node

func _ready():
	#get player as target
	target = get_node("../Player")

func _process(delta):
	#get mouse and player position and lerp between them
	var _mouse_position:Vector2 = get_global_mouse_position()
	var _target_position:Vector2 = target.position
	var _tween_position:Vector2 = lerp(_target_position, _mouse_position, .4)
	#move towards lerped position by lerping towards it
	position = lerp(position, _tween_position, 18 * delta)
