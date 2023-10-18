extends Area2D

@export var timer : Timer
@export var timer2 : Timer
var player1_on_platform : bool = false
var player2_on_platform : bool = false

func _process(delta):
	if player1_on_platform and player2_on_platform:
		#print("Both players on the platform. Pausing both timers.")
		if timer:
			timer.set_paused(true)
		if timer2:
			timer2.set_paused(true)

	if !player1_on_platform and !player2_on_platform:
		#print("No players on the platform. Resetting both timers.")
		if timer:
			timer.stop()
		if timer2:
			timer2.stop()

	if player1_on_platform and !player2_on_platform and timer.is_paused():
		print("Resuming Player 1 timer.")
		timer.set_paused(false)

	if player2_on_platform and !player1_on_platform and timer2.is_paused():
		print("Resuming Player 2 timer.")
		timer2.set_paused(false)

func _on_body_entered(body):
	print("Player entered the platform.")
	for child in body.get_children():
		if child is AudioListener2D:
			player1_on_platform = true
			print("Player 1 on the platform. Starting Player 1 timer.")
			if timer:
				timer.start()

		if child is RayCast2D:
			player2_on_platform = true
			print("Player 2 on the platform. Starting Player 2 timer.")
			if timer2:
				timer2.start()

func _on_body_exited(body):
	#print("Player exited the platform.")
	for child in body.get_children():
		if child is AudioListener2D:
			player1_on_platform = false
			print("Player 1 left the platform. Stopping Player 1 timer.")
			if timer:
				timer.stop()
		
		if child is RayCast2D:
			player2_on_platform = false
			print("Player 2 left the platform. Stopping Player 2 timer.")
			if timer2:
				timer2.stop()
