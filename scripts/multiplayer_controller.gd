extends Control

@export var address = '127.0.0.1'
@export var port = 8910
var peer

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(player_connected)
	multiplayer.peer_disconnected.connect(player_disconnected);
	multiplayer.connected_to_server.connect(connected_to_server);
	multiplayer.connection_failed.connect(connection_failed);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

@rpc("any_peer", "call_local")
func start_level():
	var scene = load("res://scenes/main.tscn").instantiate()
	scene.set_name('Main')
	get_tree().get_root().add_child(scene)
	self.hide()

func connected_to_server():
	send_player_info.rpc_id(1,'Name', multiplayer.get_unique_id())
	print('Connected to server')
	pass

func connection_failed():
	print('Connection failed')
	pass

func player_connected(id):
	print('Player Connected '+ str(id))
	pass
	
func player_disconnected(id):
	print('Player Disconnected '+ str(id))
	pass

@rpc("any_peer")
func send_player_info(name, id):
	if !GameManager.connected_players.has(id):
		GameManager.connected_players[id] = {
			"name": name,
			"id": id
		}
	if multiplayer.is_server():
		for i in GameManager.connected_players:
			send_player_info.rpc(GameManager.connected_players[i].name, i)

func _on_host_pressed():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 2);
	if error != OK:
		print('Cannot host')
		return
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	send_player_info('Name', multiplayer.get_unique_id())
	pass # Replace with function body.


func _on_join_pressed():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(address, port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	pass # Replace with function body.


func _on_start_pressed():
	start_level.rpc()
	pass # Replace with function body.

