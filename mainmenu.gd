extends Control

func _ready():
	$VBoxContainer/startbutton.grab_focus()

func _on_startbutton_pressed():
	get_tree().change_scene("res://levels/level1.tscn")

func _on_optionsbutton_pressed():
	print("options!")

func _on_quitbutton_pressed():
	get_tree().quit()

func _on_CheatCodeListener_cheat_activated():
	print("funny song is so fire")
	get_tree().change_scene("res://levels/levelfunny.tscn")
