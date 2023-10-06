extends Node2D


var peer = ENetMultiplayerPeer.new();
@export var player_scene: PackedScene; 

func _on_create_pressed():
	
	peer.create_server(135)

	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	_add_player()
	pass # Replace with function body.


func _add_player(id = 1):
	print(id);
	var player = player_scene.instantiate();
	player.name = str(id);
	call_deferred("add_child", player);
	pass

func _on_join_pressed():
	peer.create_client("localhost", 135);
	multiplayer.multiplayer_peer = peer
	pass # Replace with function body.
