extends Node

const wall = preload("res://Environment/Wall.tscn")

var defaultWallDimensions = 64
var wallScaleValue = 2

var adjustedWallDimensions = 0

var wallArrayWidth = 10
var wallArrayHeight = 10

var wallOccupancy = []

var mouseLocation = Vector2.ZERO

func _ready():
	for i in wallArrayHeight * wallArrayWidth:
		wallOccupancy.append(null)
		
	adjustedWallDimensions = defaultWallDimensions * wallScaleValue

func FreeTile(x, y):
	var occupancyIndex = x + y * wallArrayWidth
	
	if wallOccupancy[occupancyIndex] != null:
		wallOccupancy[occupancyIndex].queue_free()
		wallOccupancy[occupancyIndex] = null

func FillTile(x, y):
	if wallOccupancy[x + y * wallArrayWidth] == null:
		var wallInstance = wall.instantiate()
		add_child(wallInstance)
		
		wallInstance.position = Vector2(adjustedWallDimensions * x, adjustedWallDimensions * y)
		wallInstance.scale = Vector2(wallScaleValue, wallScaleValue)
		
		wallOccupancy[x + y * wallArrayWidth] = wallInstance

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Down"):
		mouseLocation.y += 1
	if Input.is_action_just_pressed("Up"):
		mouseLocation.y -= 1
	if Input.is_action_just_pressed("Right"):
		mouseLocation.x += 1
	if Input.is_action_just_pressed("Left"):
		mouseLocation.x -= 1
		
	if mouseLocation.y > wallArrayHeight - 1:
		mouseLocation.y = wallArrayHeight - 1
	if mouseLocation.y < 0:
		mouseLocation.y = 0
	if mouseLocation.x > wallArrayWidth - 1:
		mouseLocation.x = wallArrayWidth - 1
	if mouseLocation.x < 0:
		mouseLocation.x = 0
		
	if Input.is_action_just_pressed("Space"):
		if wallOccupancy[mouseLocation.x + mouseLocation.y * wallArrayWidth] != null:
			FreeTile(mouseLocation.x, mouseLocation.y)
			print(false)
		else:
			FillTile(mouseLocation.x, mouseLocation.y)
			print(true, mouseLocation.x, mouseLocation.y)
