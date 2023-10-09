extends Node

@export var interacting_items = {};

@export var can_move: bool = true;
signal  interaction_happened(value);


# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_happened.connect(handle_interaction)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func add_interacting_item(id, item):
	if interacting_items.has(id):
		return
	else:
		interacting_items[id] = item;

func remove_interacting_item(id):
	if !interacting_items.has(id):
		return
	else:
		interacting_items.erase(id)
		


func check_interaction(interaction):
	
	var current_interaction = interacting_items.get(interaction.id);

	can_move = true;
	match current_interaction.name:
		'Lever':
			interaction_happened.emit({
				"action": interaction.action,
				"id": interaction.id
			});
		'Button':
			#can_move = false;
			if interaction.action == 'button-push':
				can_move = false
			if interaction.action == 'button-relese':
				can_move = true
			interaction_happened.emit({
				"action": interaction.action,
				"id": interaction.id
			});

@rpc("any_peer","call_local")
func do_interaction(interaction):
	var item = interacting_items.get(interaction.id);
	if item != null:
		if interaction.action == 'lever-pull':
			item.is_active = !item.is_active
			item.interact()
		if interaction.action == 'button-push':
			item.is_pushed = true;
		if interaction.action == 'button-relese':
			item.is_pushed = false;
		
		
func handle_interaction(interaction):
	do_interaction.rpc(interaction)
