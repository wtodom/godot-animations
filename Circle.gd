extends Area2D

signal new_ball


var rng = RandomNumberGenerator.new()
var speed = rng.randi_range(100, 500)
var velocity = Vector2(
	randf_range(-1, 1),
	randf_range(-1, 1)
)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta

func _draw():
	var pos = position
	var radius = 22
	var border_radius = 28
	var r = rng.randf_range(0, 1)
	var g = rng.randf_range(0, 1)
	var b = rng.randf_range(0, 1)
	var color = Color(r, g, b)
	var color_two = Color(r + .3, g + .3, b + .3)
	$CollisionShape2D.position = pos
	$CollisionShape2D.shape.radius = border_radius + 2
	draw_circle(pos, border_radius, color)
	draw_circle(pos, radius, color_two)

func mutate():
	var roll = rng.randi_range(1, 20)
	if roll <= 6:
		new_ball.emit()
		# TODO: play special sound?
	# TODO: play sound


func _on_body_entered(body):
	print(body.name)
	match body.name:
		'NorthBoundary':
			mutate()
			velocity.y = -1 * velocity.y
		'SouthBoundary':
			mutate()
			velocity.y = -1 * velocity.y
		'EastBoundary':
			mutate()
			velocity.x = -1 * velocity.x
		'WestBoundary':
			mutate()
			velocity.x = -1 * velocity.x
		'Circle':
			print('circle')
			#var old_body_velocity = body.velocity
			#body.velocity += velocity
			#velocity -= old_body_velocity
		_:
			print(body.name)
