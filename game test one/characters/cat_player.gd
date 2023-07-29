extends CharacterBody2D

@export var move_speed : float = 100

@export var starting_direction : Vector2 = Vector2(0, 1)
# parameters/idle/blend_position

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get('parameters/playback')
func _ready():
	animation_tree.set("parameters/idle/blend_position", starting_direction)
	updateAnimationProcess(starting_direction)
#movement script
func _physics_process(_delta):
	var inputdirection = Vector2(
		Input.get_action_strength('right') - Input.get_action_strength('left'),
		Input.get_action_strength('down') - Input.get_action_strength('up')
	)
	
	updateAnimationProcess(inputdirection )
	#velocity script
	
	velocity = inputdirection * move_speed
	
	move_and_slide()
	print(inputdirection)
	newstate()
	
func updateAnimationProcess(move_input : Vector2):
	#don't change animation parameters
	if(move_input != Vector2.ZERO):
		animation_tree.set('parameters/walking/blend_position', move_input)
		animation_tree.set('parameters/idle/blend_position', move_input)
func newstate():
	if(velocity != Vector2.ZERO):
		state_machine.travel('walking')
	else:
		state_machine.travel('idle')	
