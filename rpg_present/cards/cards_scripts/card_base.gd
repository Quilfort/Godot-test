extends MarginContainer

@onready var CardDatabase = preload("res://cards/CardsDatabase.gd").new()

var Cardname = 'Footman'
@onready var CardInfo = CardDatabase.DATA[CardDatabase.get(Cardname)]
@onready var CardImg = str("res://cards/cards_assets/cards_images/", CardInfo[0],"/",Cardname,".png")

#Different states of card
enum{
	InHand,
	InPlay,
	InMouse,
	FocusInHand,
	MoveDrawnCardToHand,
	ReOrganiseHand
}

var state = InHand
var startPos = 0
var targetPos = 0
var time = 0
var drawTime = 1

@onready var OriginalScale = scale

# Called when the node enters the scene tree for the first time.
func _ready():
	print(CardInfo)
	print(CardImg)

	var CardSize = size
	$Border.scale *= CardSize/$Border.texture.get_size()
	$Card.texture = load(CardImg)
	$Card.scale *= CardSize/$Card.texture.get_size()
	$Focus.scale *= CardSize/$Focus.size
	
	var Attack = str(CardInfo[1])
	var Block = str(CardInfo[3])
	var Mana = str(CardInfo[4])
	var Name = str(CardInfo[5])
	var _SpecialText = str(CardInfo[6])
	
	$DisplayInfo/Mana.text = Mana
	$DisplayInfo/Attack.text = Attack
	$DisplayInfo/Block.text = Block
	$DisplayInfo/Name.text = Name

func _physics_process(delta):
	match state:
		InHand:
			scale = OriginalScale
		InPlay:
			pass
		InMouse:
			pass
		FocusInHand:
			scale = OriginalScale * 1.2
		MoveDrawnCardToHand:
			if time <= 1: #Always be 1
				position = startPos.lerp(targetPos, time)
				time += delta/float(drawTime)
			else:
				position = targetPos
				state = InHand
				time = 0
		ReOrganiseHand:
			pass


func _on_focus_mouse_entered():
	match state:
		InHand, ReOrganiseHand:
			state = FocusInHand	 

func _on_focus_mouse_exited():
		match state:
			FocusInHand:
				state = InHand
