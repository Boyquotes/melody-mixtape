extends TileMap

onready var color = get_parent().get_node("music").color

var count = 0.0
var old_color
var color_target
const TARGET_TIME = .5
var color_array = [Color(.39,.68,.21),Color(1,1,.32),Color(.98,.6,.07),Color(1,.15,.07),Color(.51,0,.65),Color(.07,.27,.98)]
var array_index = 0

func _process(delta):
	if color is String and color == "rgbgamingmode":
		count += delta
		if count > TARGET_TIME:
			array_index += 1
			count = 0
		if array_index > (color_array.size() - 1): array_index = 0
		color_target = Color(color_array[array_index])
		old_color = self.get_modulate()
		self.set_modulate(Color(old_color.linear_interpolate(color_target, count)))
	else:
		self.modulate = color
