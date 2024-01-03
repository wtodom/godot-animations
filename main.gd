extends Node

@export var circle_scene: PackedScene


func _ready():
	create_ball()

func _process(delta):
	pass

func create_ball():
	var circle = circle_scene.instantiate()
	circle.new_ball.connect(_on_circle_new_ball)
	circle.position = Vector2(135, 135)
	call_deferred('add_child', circle)

func _on_circle_new_ball():
	create_ball()
