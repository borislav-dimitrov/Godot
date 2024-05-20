extends CharacterBody2D

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_down_right = $RayCastDownRight
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_down_left = $RayCastDownLeft
@onready var animated_sprite_2d = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

const SPEED: float = 30
var direction = 1
var is_player: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Add Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Set direction and animate
	if ray_cast_right.is_colliding() or not ray_cast_down_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_left.is_colliding() or not ray_cast_down_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	
	# Apply moving force
	velocity.x = direction * SPEED
	
	# Move
	move_and_slide()

