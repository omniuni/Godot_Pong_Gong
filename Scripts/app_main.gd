extends Control

@export var Ball_Scene: PackedScene = preload("res://Scenes/item_ball.tscn")
@export var Ball_Speed: int = 0
@export var Ball_Speedup: int = 0

var current_ball: Node2D = null

var score_left: int = 0
var score_right: int = 0

var add_ball_in: int = 0

func _ready():
	$BarTop.update_title("Godot Pong")
	$ItemPanelLeft.set_light_color(GameSettings.color_p1)
	$LabelLeftScore.add_theme_color_override("font_color", GameSettings.color_p1)
	$ItemPanelRight.set_light_color(GameSettings.color_p2)
	$LabelRightScore.add_theme_color_override("font_color", GameSettings.color_p2)
	update_rounds()
	pass
	
func update_add(visble: bool):
	$CountPanel.visible = visble
	var secs_left = add_ball_in
	$CountPanel/Label.text = str(secs_left)
	pass

func add_ball():
	if current_ball == null:
		current_ball = Ball_Scene.instantiate()
		current_ball.position = $Node2DSpawn.position-current_ball.center_offset()
		current_ball.set_ball_speed(Ball_Speed)
		current_ball.set_ball_speedup(Ball_Speedup)
		Beeper.play_ball()
		add_child(current_ball)
	pass
	
func update_scores():
	$LabelLeftScore.text = str(score_left)
	$LabelRightScore.text = str(score_right)
	update_rounds()
	$BarTop/ButtonAddBall.visible = true
	pass
	
func update_rounds() -> void:
	var round = score_left+score_right
	var max_round = (GameSettings.rounds+1)/2
	$LabelRounds.text = "Round "+str(round)+" of "+str(GameSettings.rounds)
	if score_left == max_round || score_right == max_round:
		show_win()
	pass

func show_win() -> void:
	var text = " Player Wins"
	if score_left > score_right:
		text = "Left"+text
	else:
		text = "Right"+text
	$WinPanel/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/LabelWinner.text = text
	$WinPanel.visible = true
	pass

func _on_button_add_ball_pressed() -> void:
	if current_ball == null and add_ball_in == 0:
		add_ball_in = 4
	$BarTop/ButtonAddBall.visible = false
	pass

func _on_item_panel_left_kick(direction: Vector2) -> void:
	if current_ball != null:
		var kick_direction = direction+Vector2(1,0)
		current_ball.kick_off(kick_direction)
	pass

func _on_item_panel_right_kick(direction: Vector2) -> void:
	if current_ball != null:
		var kick_direction = direction+Vector2(-1,0)
		current_ball.kick_off(kick_direction)
	pass

func _on_rigid_body_goal_left_body_entered(body: Node) -> void:
	if body.get_parent().name.contains("Ball"):
		Beeper.play_out()
		current_ball.queue_free()
		score_right = score_right+1
		update_scores()
	pass

func _on_rigid_body_goal_right_body_entered(body: Node) -> void:
	if body.get_parent().name.contains("Ball"):
		Beeper.play_out()
		current_ball.queue_free()
		score_left = score_left+1
		update_scores()
	pass

func _on_rigid_body_ceiling_body_entered(body: Node) -> void:
	if body.get_parent().name.contains("Ball"):
		Beeper.play_wall()
	elif body.get_parent().name.contains("Panel"):
		Beeper.play_panel()
	pass

func _on_rigid_body_floor_body_entered(body: Node) -> void:
	if body.get_parent().name.contains("Ball"):
		Beeper.play_wall()
	elif body.get_parent().name.contains("Panel"):
		Beeper.play_panel()
	pass

func _on_button_done_pressed() -> void:
	Scenes.change_to(get_tree(), Scenes.menu)
	pass

func _on_timer_timeout() -> void:
	if add_ball_in != 0:
		add_ball_in = add_ball_in-1
		update_add(true)
		if add_ball_in <= 0:
			update_add(false)
			add_ball()
	pass
