extends Control

@export var Address = "127.0.0.1"
@export var port = 8910
var peer = null

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(PlayerConnected)
	multiplayer.peer_disconnected.connect(PlayerDisconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func PlayerConnected(id):
	print("Player Connected " + str(id))
	
func PlayerDisconnected(id):
	print("Player Disconnected " + str(id))

func connected_to_server():
	print("connected to server")
	SendPlayerInformation.rpc_id(1, $LineEdit.text, multiplayer.get_unique_id())


func connection_failed():
	print("no establish connection :O")

@rpc("any_peer")
func SendPlayerInformation(name, id):
	if !MultiplayerManager.players.has(id):
		MultiplayerManager.players[id] = {
			"name": name,
			"id": id
		}
	
	if multiplayer.is_server():
		for i in MultiplayerManager.players:
			SendPlayerInformation.rpc(MultiplayerManager.players[i].name, i)
			
func _on_join_pressed():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(Address, port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)


func _on_host_pressed():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 2)
	if error != OK:
		print("can't host :O " + str(error))
		return
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	
	multiplayer.set_multiplayer_peer(peer)
	SendPlayerInformation($LineEdit.text, multiplayer.get_unique_id())
	print("waiting for players")


@rpc("any_peer", "call_local")
func StartGame():
	var scene = load("res://level_1_scene/level_1.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()

func _on_start_pressed():
	StartGame.rpc()
