extends Node2D

@onready var animated_left = %Animated_left
@onready var animated_right_short = %Animated_right_short
@onready var animated_right_long = %Animated_right_long


func _ready():
	animated_left.play("idle")
	animated_right_long.visible = false
	animated_right_short.visible = true
	animated_right_short.play("idle")


func grab_short():
	animated_right_short.visible = true
	animated_right_long.visible = false
	animated_right_short.play("grab")

func grab_long():
	animated_right_short.visible = false
	animated_right_long.visible = true
	animated_right_long.play("grab")
	await get_tree().create_timer(0.8).timeout
	animated_right_short.visible = true
	animated_right_long.visible = false
	animated_right_short.play("idle")
