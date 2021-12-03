extends Control



func _ready():
	get_tree().paused



func _on_KC_pressed():
	get_tree().change_scene("res://Menu/Win.tscn")


func _on_KA_pressed():
	get_tree().change_scene("res://Menu/Lose.tscn")


func _on_Resume_pressed():
	get_tree().change_scene("res://Town/Tumbleweed.tscn")

func _on_Quit_pressed():
	get_tree().change_scene("res://Menu/Menu.tscn")
