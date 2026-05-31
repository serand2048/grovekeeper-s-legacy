extends CharacterBody2D

const SPEED = 100.0

@onready var player_sprite = $AnimatedSprite2D
var last_direction = "down"  # начальное направление

func _physics_process(_delta):
	# Получаем ввод
	var dir = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)
	
	# Двигаемся
	velocity = dir.normalized() * SPEED
	move_and_slide()
	
	# Определяем анимацию только если есть движение
	if dir.length() > 0.1:
		if abs(dir.x) > abs(dir.y):          # горизонталь важнее
			last_direction = "right" if dir.x > 0 else "left"
		else:                                # вертикаль
			last_direction = "down" if dir.y > 0 else "up"
	
	# Выбираем анимацию
	player_sprite.play("idle_" + last_direction)
	
