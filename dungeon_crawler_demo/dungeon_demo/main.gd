extends Node

var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var creatures = []
	findByClass(self, "CharacterBody2D", creatures)
	for creature in creatures:
		if creature.name != "Player":
			print(creature.name)
			creature.target = $Player
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Find all nodes of a certain class
func findByClass(node: Node, className : String, result : Array) -> void:
	print(node)
	if node.is_class(className):
		result.push_back(node)
	for child in node.get_children():
		findByClass(child, className, result)

func manage_player_health(dam_perc: float) -> void:
	var hp_left = $Hud.update_health_bar(dam_perc)
	if hp_left <= 0:
		game_over()
	pass

func game_over() -> void:
	$Hud.show_game_over()
	$Player.hide()
	
func new_game():
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$Hud.show_message("Get Ready")


func _on_player_stamina_change(stam: float) -> void:
	$Hud.update_stamina_bar(stam)
