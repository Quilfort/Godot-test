extends TextureButton

var DeckSize = INF

func _ready():
	scale *= $"../../".CardSize/size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(_event):
	if Input.is_action_just_pressed("leftclick"):
		if DeckSize > 0:
			DeckSize = $"../../".DrawCard()
			if DeckSize == 0:
				disabled = true
