extends Area2D


var active = false
var count = 0
var camera = null

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$QuestionMark.visible = active

func _input(event):
	if get_node_or_null("DialogNode") == null:
		if event.is_action_pressed("ui_accept") and active:
			var dialog = Dialogic.start("Bartender")
			add_child(dialog)



func _on_NPC_body_entered(body):
	if body.name == 'Player':
		active = true


func _on_NPC_body_exited(body):
	if body.name == 'Player':
		active = false
