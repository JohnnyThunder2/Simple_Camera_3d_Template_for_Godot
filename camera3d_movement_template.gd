##= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
##					Simple Camera_3d Template
## 					by William Torpey - MIT licence
##	This script is to help Game Jams or people who hate wasteing time by giving GameDevs 
##      a quick script for setting up basic Camer3d controls in a new project
##	Just add Keybinds for: Camera_Forward, Camera_Back, Camera_Right, Camera_Left, Camera_Up, 
##	Camera_Down, Sprint and Free_Look
##	Linux Install location: $HOME/.config/godot/script_templates/Camera3D/
##      MacOS Install location: $HOME/Library/Application Support/Godot/script_templates/Camera3D/
##      Windows Install Location: %APPDATA%\Godot\script_templates\Camera3D\
##= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

extends Camera3D

var mouseSensitivity: float = 0.15
var sprintSpeed: float = 1.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event.is_action_pressed("Quit"):
		get_tree().quit()
		
	if event.is_action_pressed("Sprint"):
		sprintSpeed = 5
	elif event.is_action_released("Sprint"):
		sprintSpeed = 1
	
	if event.is_action_pressed("Free_Look"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event.is_action_released("Free_Look"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if event is InputEventMouseMotion && Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		self.rotation_degrees.x -= event.relative.y * mouseSensitivity
		self.rotation_degrees.x = clamp(self.rotation_degrees.x, -90,90)
		self.rotation_degrees.y -= event.relative.x * mouseSensitivity

func _process(delta: float) -> void:	
	if Input.is_action_pressed("Camera_Forward"):
		position  -= transform.basis.z.normalized() * 10 * delta * sprintSpeed
	elif Input.is_action_pressed("Camera_Back"):
		position  += transform.basis.z.normalized() * 10 * delta * sprintSpeed
	if Input.is_action_pressed("Camera_Right"):
		position  += transform.basis.x.normalized() * 10 * delta * sprintSpeed
	elif Input.is_action_pressed("Camera_Left"):
		position  -= transform.basis.x.normalized() * 10 * delta * sprintSpeed
	if Input.is_action_pressed("Camera_Up"):
		position  += transform.basis.y.normalized() * 10 * delta * sprintSpeed
	elif Input.is_action_pressed("Camera_Down"):
		position  -= transform.basis.y.normalized() * 10 * delta * sprintSpeed
