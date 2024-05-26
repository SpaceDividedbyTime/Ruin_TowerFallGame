extends CharacterBody2D

var playerInput = Vector2.ZERO

@export var speed := 400

func GetPlayerInput():
	playerInput = Vector2.ZERO
	
	if (Input.is_action_pressed("Left")):
		playerInput.x -= 1
	if (Input.is_action_pressed("Right")):
		playerInput.x += 1
	if (Input.is_action_pressed("Up")):
		playerInput.y -= 1
	if (Input.is_action_pressed("Down")):
		playerInput.y += 1

func SetPlayerMovement(delta):
	velocity = playerInput.normalized() * speed * delta

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	GetPlayerInput()
	SetPlayerMovement(1)
	print(velocity)
	move_and_slide()
