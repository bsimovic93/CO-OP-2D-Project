extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0

signal hit(player_id);

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())


func _physics_process(delta):
	
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
	# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta

		# Handle Jump.
		if Input.is_action_just_pressed("action_jump") and is_on_floor() and InteractionManager.can_move and InteractionManager.is_focused:
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction and InteractionManager.can_move and InteractionManager.is_focused:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)


		move_and_slide()

func die():
	hit.emit(multiplayer.get_unique_id())


func _enter_tree():
	print('multiplayer started')
	set_multiplayer_authority(name.to_int());


func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.get_node('../').is_in_group('Shocker'):
			print('ded')
			die()
	pass # Replace with function body.
