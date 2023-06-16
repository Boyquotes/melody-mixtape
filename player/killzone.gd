extends Area2D

# var currentSong = get_parent().get_node("music").currentSong

signal died

func _on_Area2D_body_entered(body):
	emit_signal("died")
