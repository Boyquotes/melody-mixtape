extends Area2D

signal complete


func _on_complete_body_entered(body):
	emit_signal("complete")
