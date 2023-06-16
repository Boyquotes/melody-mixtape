extends AudioStreamPlayer

# SONG
#		            Song Name          BPM   FILE LOCATION								 COLOUR
const FUNNYSONG = ["Funny Song",       90,  "res://assets/audio/songs/funnysong.ogg",	 "rgbgamingmode"]
const DAILYBEETLE = ["Daily Beetle",   100, "res://assets/audio/songs/dailybeetle.ogg",	 Color(1, 1, 0.7)]
const JAZZYFRENCHY = ["Jazzy Frenchy", 114, "res://assets/audio/songs/jazzyfrenchy.ogg"]
const QUIRKYDOG = ["Quirky Dog",       89,  "res://assets/audio/songs/quirkydog.ogg"]
const RHINOCEROS = ["Rhinoceros",      126, "res://assets/audio/songs/rhinoceros.ogg"]
const THECOMPLEX = ["The Complex",     104, "res://assets/audio/songs/thecomplex.ogg",	Color(1, 0.3, 0.3)]

#onready var currentlevel = get_tree().current_scene.name
export var currentLevel = "level1"

# Current Song
func getCurrentSong():
#	if currentLevel == str("level1"):
	currentSong = FUNNYSONG     
#	else:
#		currentSong = FUNNYSONG

	return currentSong

func playCurrentSong():
	var song = ResourceLoader.load(currentSong[2])
	self.stream = song
	self.play()

export(Array) var currentSong = getCurrentSong()
export(Color) var color = currentSong[3]

func _ready():
	getCurrentSong()
	playCurrentSong()
