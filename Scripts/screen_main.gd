extends Control

@export var Ball_Scene: PackedScene = preload("res://Scenes/item_ball.tscn")
@export var Ball_Speed: int = 0
@export var Ball_Speedup: int = 0
@export var Action_Two_Text: String = ""

@onready var menu_bar: UiBarTop = $BarTop
@onready var score_left_p1: Label = $LabelLeftScore
@onready var score_right_p2: Label = $LabelRightScore
@onready var label_rounds: Label = $LabelRounds
@onready var spawn: Node = $Node2DSpawn
@onready var panel_left_p1: ItemPanel = $ItemPanelLeft
@onready var panel_right_p2: ItemPanel = $ItemPanelRight
@onready var ui_win: Panel = $WinPanel
@onready var ui_win_label: Label = $WinPanel/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/LabelWinner
@onready var ui_count_panel: Panel = $CountPanel
@onready var ui_count_panel_label: Label = $CountPanel/Label

var current_ball: ItemBall = null

var score_left: int = 0
var score_right: int = 0

var add_ball_in: int = 0

func _ready():
	GameSettings.apply_custom_key_bindings()
	init_ui()
	update_rounds()
	pass
	
func _input(event: InputEvent) -> void:
	var event_name: String = GameSettings.get_action_name(event)
	if event_name.to_lower().contains("ball"):
		_on_bar_top_on_secondary_action()
	pass
	
func init_ui() -> void:
	panel_left_p1.Light_Color = GameSettings.Color_P1
	score_left_p1.add_theme_color_override("font_color", GameSettings.Color_P1)
	panel_right_p2.Light_Color = GameSettings.Color_P2
	score_right_p2.add_theme_color_override("font_color", GameSettings.Color_P2)
	pass

func update_rounds() -> void:
	var gameRounds = score_left+score_right
	var max_round = (GameSettings.Rounds+1)/2
	label_rounds.text = "Round "+str(gameRounds)+" of "+str(GameSettings.Rounds)
	if score_left == max_round || score_right == max_round:
		show_win()
	pass

func show_win() -> void:
	var text = " Player Wins"
	if score_left > score_right:
		text = "Left"+text
	else:
		text = "Right"+text
	ui_win_label.text = text
	ui_win.visible = true
	pass

func update_add(visble: bool):
	ui_count_panel.visible = visble
	var secs_left = add_ball_in
	ui_count_panel_label.text = str(secs_left)
	pass

func add_ball():
	if current_ball == null:
		current_ball = Ball_Scene.instantiate()
		current_ball.position = spawn.position-current_ball.center_offset()
		current_ball.Ball_Speed = Ball_Speed
		current_ball.set_ball_speedup(Ball_Speedup)
		Beeper.play_ball()
		add_child(current_ball)
	pass
	
func update_scores():
	score_left_p1.text = str(score_left)
	score_right_p2.text = str(score_right)
	update_rounds()
	menu_bar.Action_Two = Action_Two_Text
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

func _on_timer_timeout() -> void:
	if add_ball_in != 0:
		add_ball_in = add_ball_in-1
		update_add(true)
		if add_ball_in <= 0:
			update_add(false)
			add_ball()
	pass

func _on_bar_top_on_secondary_action() -> void:
	if current_ball == null and add_ball_in == 0:
		add_ball_in = 4
	menu_bar.Action_Two = ""
	pass

func _on_button_done_pressed() -> void:
	Beeper.play_ui()
	Scenes.change_to(get_tree(), Scenes.menu)
	pass

func _on_ui_target_left_panel_on_target_end() -> void:
	panel_left_p1.request_move_stop()
	pass

func _on_ui_target_left_panel_on_target_touch(target: Vector2) -> void:
	panel_left_p1.request_move_to(target)
	pass

func _on_ui_target_left_panel_on_target_drag(target: Vector2) -> void:
	panel_left_p1.request_move_to(target)
	pass



func _on_ui_target_right_panel_on_target_end() -> void:
	panel_right_p2.request_move_stop()
	pass
	
func _on_ui_target_right_panel_on_target_touch(target: Vector2) -> void:
	panel_right_p2.request_move_to(target)
	pass

func _on_ui_target_right_panel_on_target_drag(target: Vector2) -> void:
	panel_right_p2.request_move_to(target)
	pass
