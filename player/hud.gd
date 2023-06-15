extends CanvasLayer

onready var bpm_label = $bpm
onready var song_label = $song
onready var timing_label = $timing
onready var currentSong = get_parent().get_node("music").currentSong
onready var songName = currentSong[0]
onready var bpm = currentSong[1]

onready var player = get_parent().get_node("player")
onready var _animated_sprite = $AnimatedSprite
onready var beatTime = 1
onready var beatTiming = ""

onready var color = get_parent().get_node("music").color

var count = 0.0
var old_color
var color_target
const TARGET_TIME = .5
var color_array = [Color(.39,.68,.21),Color(1,1,.32),Color(.98,.6,.07),Color(1,.15,.07),Color(.51,0,.65),Color(.07,.27,.98)]
var array_index = 0

func _process(delta):
	bpm_label.text = str("BPM: ",bpm)
	song_label.text = str(songName)
	
	if color is String and color == str("rgbgamingmode"):
		count += delta
		if count > TARGET_TIME:
			array_index += 1
			count = 0
		if array_index > (color_array.size() - 1): array_index = 0
		color_target = Color(color_array[array_index])
		old_color = bpm_label.get_modulate()
		old_color = song_label.get_modulate()
		old_color = timing_label.get_modulate()
		old_color = _animated_sprite.get_modulate()
		bpm_label.set_modulate(Color(old_color.linear_interpolate(color_target, count)))
		song_label.set_modulate(Color(old_color.linear_interpolate(color_target, count)))
		timing_label.set_modulate(Color(old_color.linear_interpolate(color_target, count)))
		_animated_sprite.set_modulate(Color(old_color.linear_interpolate(color_target, count)))
	
#	bpm_label.modulate = Color(color)
#	song_label.modulate = Color(color)
#	timing_label.modulate = Color(color)
#	_animated_sprite.modulate = Color(color)
	
	timing_label.text = str(player.beatTiming)

	var beatTimer = player.beatTimerGlobal

	if beatTimer >= 0.9 and beatTimer <= 1  or beatTimer <= 0.1 and beatTimer >= 0.0:
		$AnimatedSprite.set_frame(3)
	elif beatTimer > 0.8 and beatTimer < 0.9 or beatTimer < 0.2 and beatTimer > 0.1:
		$AnimatedSprite.set_frame(2)
	elif beatTimer > 0.7 and beatTimer < 0.8 or beatTimer < 0.3 and beatTimer > 0.2:
		$AnimatedSprite.set_frame(1)
	else:
		$AnimatedSprite.set_frame(0)
