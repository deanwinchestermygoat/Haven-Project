extends RichTextLabel
var text_number = -1
var click_state = false
var waiting_for_choice = false
@onready var text_box: TextureRect = $"../Text Box"
@onready var rich_text_label: RichTextLabel = $"."
@onready var button: Button = $"../Button"
@onready var button_2: Button = $"../Button2"
@onready var andrew_image: TextureRect = $"../TextureRect2"
@onready var chef_image: TextureRect = $"../TextureRect3"
var text_content1: Array = [
	"[enter_chef]",
	"Chef: I swear I hid those!",
	"Andrew: You really don't want me to make the perfect cake now do you?",
	"Chef: Someone of your caliber shouldn't be able to!",
	"[choice]",
]
var after_lines: Array = [
    "next_scene"
]
var speaker_name = "Andrew:"
func _ready() -> void:
	button.hide()
	button_2.hide()
	button.pressed.connect(_on_choice.bind(true))
	button_2.pressed.connect(_on_choice.bind(false))
func _on_choice(yes: bool) -> void:
	waiting_for_choice = false
	button.hide()
	button_2.hide()
	if yes:
		text_content1 = [
	"Andrew: Just you wait- I'm going to follow this recipe to the letter and make the best cake you've ever laid eyes on!!",
	"Chef: Good luck with that..",
	"[exit_chef]",
	"Andrew: Can't wait to move out and get that guy outta my hair.  Let's see.. Next on the list is sugar!",
	"Andrew: Man, I love sugar.",
	"next_scene",
]
		NewScript.evil_cake = true
		print("normal")
	else:
		text_content1 = [
	"Andrew: Listen here Edward, I've had enough of your disrespect! I'm going to invent the new best recipe and YOU are going to see just how great I can be!",
	"Chef: HAH! You batter believe you sound HILARIOUS right now! We'll see exactly what you make soon enough.",
	"[exit_chef]",
	"Andrew: He makes me so mad sometimes. Urgh.",
	"Andrew: What usually goes in a cake..?",
	"Andrew: Right; sugar.",
	"next_scene ",]
	text_number = -1
	click_state = true
	NewScript.evil_cake = false
	print("evil")
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("leftclick") and not waiting_for_choice:
		click_state = not click_state
	if click_state == true:
		text_number+=1
		click_state = not click_state
		if text_number>=text_content1.size():
			rich_text_label.hide()
			text_box.hide()
			andrew_image.hide()
			chef_image.hide()
			text_number = 0
		else:
			text = text_content1[text_number]
			if text == "[choice]":
				text = text_content1[text_number - 1] 
				waiting_for_choice = true
				button.show()
				button_2.show()
				button_2.text = "Screw that guy"
				button.text = "Follow the recipe"
				print(text_number, " ", text_content1[text_number])
				return
			speaker_name = text_content1[text_number].get_slice(" ", 0)
			if speaker_name == "Andrew:":
				chef_image.hide()
				andrew_image.show()
			elif speaker_name == "Chef:":
				andrew_image.hide()
				chef_image.show()
			elif speaker_name == "next_scene":
				get_tree().change_scene_to_file("res://QTE3.tscn")
