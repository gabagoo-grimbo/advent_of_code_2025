extends PanelContainer

@onready var input_text: TextEdit = %InputText
@onready var output_text: TextEdit = %OutputText
@onready var solve_button: Button = %SolveButton

func _ready() -> void:
	solve_button.pressed.connect(_on_solve_button_pressed)

func parse_ranges(input: String) -> Array[Array]:
	var ranges: Array[Array]
	
	var string_ranges: PackedStringArray = input.rsplit(",")
	
	for string in string_ranges:
		var tokens = string.rsplit("-")
		ranges.append(range(tokens[0].to_int(),tokens[1].to_int()+1))
	
	return ranges

func solve(input: String) -> int:
	return part_1(input)

func part_1(input: String) -> int:
	var ranges: Array = parse_ranges(input)
	
	var code: int = 0
	
	for current_range in ranges:
		for id in current_range:
			if is_invalid(id):
				code += id
	
	return code

func is_invalid(id) -> bool:
	var invalid: bool = false
	
	var id_length: int = str(id).length()
	if id_length % 2 == 0: # Is even
		var tokens: Array[String] = split_half(str(id))
		if tokens[0] == tokens[1]:
			invalid = true
	
	return invalid

func split_half(string: String) -> Array[String]:
	var string_length: int = string.length()
	var half_length = ceil(float(string_length) / 2)
	
	var tokens: Array[String]
	tokens.append(string.left(half_length))
	tokens.append(string.right(half_length))
	
	return tokens
 
func _on_solve_button_pressed() -> void:
	output_text.text = str(solve(input_text.text))
