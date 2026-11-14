extends Node
@onready var pointer: Sprite2D = $"QTE bar/pointer"
@onready var start: Marker2D = $"QTE bar/start"
@onready var end: Marker2D = $"QTE bar/end"
@onready var safestartpos: Marker2D = $"QTE bar/safestartpos"
@onready var safeendpos: Marker2D = $"QTE bar/safeendpos"
@onready var score_counter: RichTextLabel = $"QTE bar/scorecounter"
var direction = 1
var score = 0
func _process(delta: float) -> void:
	if pointer.position.x <=start.position.x:
		direction = 1
	elif pointer.position.x>= end.position.x:
		direction = -1
	pointer.position.x +=25*direction
	if Input.is_action_just_pressed("leftclick"):
		if pointer.position.x >= safestartpos.position.x and pointer.position.x <= safeendpos.position.x: 
			score+=1
	score_counter.text = ("Score= %d"%[score])
	
