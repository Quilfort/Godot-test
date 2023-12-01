extends Node2D

#Different states of card
enum{
	InHand,
	InPlay,
	InMouse,
	FocusInHand,
	MoveDrawnCardToHand,
	ReOrganiseHand
}

const CardSize = Vector2(125, 175)
const CardBase = preload("res://cards/card_base.tscn")
const PlayerHand = preload("res://cards/Player_Hand.gd")

var CardSelected = []
@onready var DeckSize = PlayerHand.CardList.size()

#Pos en rotation cards
@onready var CentreCardOval = Vector2(get_viewport().size) * Vector2(0.5, 1.25)
@onready var HorizontalRadius = get_viewport().size.x * 0.45
@onready var VerticalRadius = get_viewport().size.y * 0.4
var Angle = deg_to_rad(90) - 0.5
var OvalAngleVector = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func DrawCard():
	var new_card = CardBase.instantiate()
	CardSelected = randi() % DeckSize
	new_card.Cardname = PlayerHand.CardList[CardSelected]
	OvalAngleVector = Vector2(HorizontalRadius * cos(Angle), - VerticalRadius * sin(Angle))
	new_card.startPos = $Deck.position - CardSize
	new_card.targetPos = CentreCardOval + OvalAngleVector - CardSize
#	new_card.rotation = 90 - rad_to_deg(Angle)
	new_card.state = MoveDrawnCardToHand
	add_child(new_card)
	Angle += 0.25
	DeckSize -= 1
	return DeckSize
