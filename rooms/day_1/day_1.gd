extends PanelContainer

@onready var input_text: TextEdit = %InputText
@onready var output_text: TextEdit = %OutputText
@onready var solve_button: Button = %SolveButton
@onready var starting_position_text: TextEdit = %StartingPositionText
@onready var mode_menu: OptionButton = %ModeMenu

func _ready() -> void:
	solve_button.pressed.connect(_on_solve_button_pressed)

func parse_instructions(input: String) -> Array[Dictionary]:
	var tokens: PackedStringArray
	
	tokens = input.rsplit("\n",false,0)
	
	#print(tokens)
	
	var instructions: Array[Dictionary]
	
	for token in tokens:
		var direction: String = token[0]
		var distance: int = token.to_int()
		
		var instruction: Dictionary = {
			"direction": direction,
			"distance": distance
		}
		
		instructions.append(instruction)
	
	return instructions

func solve(instructions: Array[Dictionary]) -> int:
	match mode_menu.get_item_text(mode_menu.selected).to_lower():
		"part 1":
			return part_1(instructions)
		"part 2":
			return part_2(instructions)
	return 0

func part_2(instructions: Array[Dictionary]) -> int:
	# I gave up after 3 hours and followed some toturial
	var dial_position: int = starting_position_text.text.to_int()
	var times_hit_0: int = 0
	
	for instruction in instructions:
		var distance: int = instruction["distance"]
		var direction: String = instruction["direction"].to_lower()
		
		if direction == "l":
			distance *= -1
		
		var divisions: int = distance / (100 * sign(distance))
		
		times_hit_0 += divisions
		
		var mod = modulus(distance,100 * sign(distance))
		match direction:
			"l":
				if dial_position != 0 and dial_position + mod <= 0:
					times_hit_0 += 1
			"r":
				if dial_position + mod >= 100:
					times_hit_0 += 1
		
		dial_position = modulus(dial_position + distance, 100)
	
	return times_hit_0

func part_1(instructions: Array[Dictionary]) -> int:
	var dial_position: int = starting_position_text.text.to_int()
	var times_hit_0: int = 0
	
	for instruction in instructions:
		var distance: int = instruction["distance"]
		
		if instruction["direction"].to_lower() == "l":
			distance *= -1
		
		dial_position += distance
		
		dial_position = wrap(dial_position,0,100)
		if dial_position == 0:
			times_hit_0 += 1
	
	return times_hit_0


func modulus(value: float, divisor: float) -> int:
	return value - (divisor * floor(value / divisor))

func _on_solve_button_pressed() -> void:
	output_text.text = str(solve(parse_instructions(input_text.text)))
