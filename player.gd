extends CharacterBody3D


const SPEED = 10.0
const JUMP_VELOCITY = 4.5
const death_height = -5
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_right","move_left")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Move automatically towards the end goal
	velocity.z = SPEED
	move_and_slide()
	
	
func _process(delta):
	# Potential death screen? Deffo edit this but the logic works
	# Add a button to change scene back
	if position.y < death_height:
		# End the game
		get_tree().change_scene_to_file("res://end_state.tscn")

