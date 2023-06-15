extends KinematicBody2D

onready var currentSong = get_parent().get_node("music").currentSong
onready var bpm = float(currentSong[1])

const ACCELERATION = 3000
const LIMIT_SPEED_Y = 1200
const SHORT_HOP_HEIGHT = 23000
const JUMP_SQUAT = 4
const MAX_COYOTE_TIME = 6
const JUMP_BUFFER_TIME = 5
const GRAVITY = 2100
const DASH_SPEED = 20000

# JUMP HEIGHT CONSTANTS (names totally not stolen from quaver)
const PERF = 39000
const GOOD = 36500
const OK = 34000
const BAD = 30000

var velocity = Vector2()
var axis = Vector2()
var maxSpeed = 10000

onready var beatsPerSecond = (bpm / 60.0)
onready var beatTimerStep = (beatsPerSecond / 60.0)
onready var beatTimer = 1.0
export var beatTimerGlobal = 1.0
export var beatTiming = str("")
var jumpHeight = 35000
var coyoteTimer = 0
var jumpBufferTimer = 0
var dashTime = 0

var canJump = false
var friction = false
var isDashing = false
var hasDashed = false

func _physics_process(delta):
	if beatTimer < 1:
		beatTimer += beatTimerStep
	else:
#		print("beat!!!!!!!!!!!")
		beatTimer = 0

	beatTimerGlobal = beatTimer
	
	if velocity.y <= LIMIT_SPEED_Y:
		if !isDashing:
			maxSpeed = 10000
			velocity.y += GRAVITY * delta
		if isDashing:
			velocity.y += GRAVITY / 4.0 * delta

	friction = false

	getInputAxis()
	dash(delta)

	if is_on_floor():
		canJump = true
		coyoteTimer = 0
		beatTiming = ""
	else:
		coyoteTimer += 1
		if coyoteTimer > MAX_COYOTE_TIME:
			canJump = false
			coyoteTimer = 0
		friction = true
	jumpBuffer(delta)
	
	horizontalMovement(delta)

	if Input.is_action_pressed("jump"):
		if canJump:
			if beatTimer > 0.9 and beatTimer < 1  or beatTimer < 0.1 and beatTimer > 0.0:
				jumpHeight = PERF
				print("PERF")
				beatTiming = "PERF"
			elif beatTimer > 0.8 and beatTimer < 0.9 or beatTimer < 0.2 and beatTimer > 0.1:
				jumpHeight = GOOD
				print("GOOD")
				beatTiming = "GOOD"
			elif beatTimer > 0.7 and beatTimer < 0.8 or beatTimer < 0.3 and beatTimer > 0.2:
				jumpHeight = OK
				print("OK")
				beatTiming = "OK"
			else:
				jumpHeight = BAD
				print("BAD")
				beatTiming = "BAD"

			jump(delta)
			canJump = false
			airFriction()

	jumpBuffer(delta)

	velocity = move_and_slide(velocity, Vector2.UP)

func jump(delta):
	velocity.y = -jumpHeight * delta
	print(jumpHeight)

func airFriction():
	if friction:
		velocity.x = lerp(velocity.x, 0, 0.01)

func jumpBuffer(delta):
	if jumpBufferTimer > 0:
		if is_on_floor():
			jump(delta)
		jumpBufferTimer -= 1

func horizontalMovement(delta):
	if Input.is_action_pressed("right"):
		velocity.x = min(velocity.x + ACCELERATION * delta, maxSpeed * delta)

	elif Input.is_action_pressed("left"):
		velocity.x = max(velocity.x - ACCELERATION * delta, -maxSpeed * delta)

	else:
		velocity.x = lerp(velocity.x, 0, 0.4)
		
func dash(delta):
	if !hasDashed:
		if Input.is_action_just_pressed("dash"):
			print("dash")
			velocity = axis * DASH_SPEED * delta
			isDashing = true
			hasDashed = true
	if isDashing:
		maxSpeed = 30000
		dashTime += 1
		if dashTime >= int(0.25 * 1 / delta):
			isDashing = false
			dashTime = 0
	if is_on_floor() && velocity.y >= 0:
		hasDashed = false

func getInputAxis():
	axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	axis.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
#	axis = axis.normalized()


func _on_Area2D_died():
	position = Vector2(42, 161)
	print("absolute bozoz")
