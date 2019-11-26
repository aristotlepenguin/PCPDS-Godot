extends Node

# Node names.
var sound
var timer
var pause
var scene
var canvas
var window
var display
var nametag
var dialogue
var pauseCanvas
var dialogueBox
var dialboxLeft
var dialboxRight

# Load nodes for all game systems.
func _ready():
	
	# Set the global rootnode to the root of the current scene.
	global.rootnode = get_node('.').owner
	
	
	
	# Create the scene node and add under systems node.
	scene = Node.new()
	scene.set_name('Scene')
	scene.set_script(load("res://code/scene.gd"))
	add_child(scene)
	
	
	
	# Load the image system under the display variable.
	display = Sprite.new() # Create a new Sprite node.
	display.set_name('Display') # Give it the name Display.
	display.set_script(load('res://code/display.gd')) # Attatch the display script.
	add_child(display) # Add the node under the Systems node.
	
	
	
	# Load the sound system under the sound variable.
	sound = Node.new() # Create a new Node node.
	sound.set_name('Sound') # Give it the name Sound.
	sound.set_script(load('res://code/sound.gd')) # Attatch the sound script.
	add_child(sound) # Add the node under the Systems node.
	
	
	
	# Load the pause screen system under the pause variable.
	pause = Control.new() # Make a new contol node.
	pause.name = 'Pause' # Name the node Pause.
	pause = load('res://scenes/Pause_Screen.tscn').instance() # Attatch the Pause_Screen scene to pause.
	pause.visible = false # Make the scene invisible.



# Function to view the dialogue box on a scene and add the pause menu.
func dialogue(script):
	
	# A canvas layer above all the rest for pausing.
	pauseCanvas = CanvasLayer.new()
	pauseCanvas.name = 'Pause Canvas'
	add_child(pauseCanvas)
	
	# A canvas layer node for keeping things on top such as the dialogue box.
	canvas = CanvasLayer.new()
	canvas.name = 'Dialogue Canvas'
	pauseCanvas.add_child(canvas)
	
	# Load the DialogueBox under canvas.
	dialogueBox = TextureRect.new()
	dialogueBox.name = 'Dialogue Box'
#	dialogueBox.color = Color(0, 0, 0, 0.9)
#	dialogueBox.modulate = Color(1, 1, 1, 0.95)
	dialogueBox.margin_top = 790
	dialogueBox.margin_bottom = 1080
	dialogueBox.margin_left = 0
	dialogueBox.margin_right = 1920
	dialogueBox.set_script(load('res://code/dialoguebox.gd'))
	dialogueBox.texture = load('res://images/dialoguebox/dialogueBox.png')
	
#	# Create dialogue box ends.
#	dialboxRight = ColorRect.new()
#	dialboxRight.name = 'Dialogue Box Right'
#	dialboxRight.color = Color.black
#	dialboxRight.margin_bottom = 290
#	dialboxRight.margin_top = 0
#	dialboxRight.margin_left = -405
#	dialboxRight.margin_right = 0
#	dialboxRight.material = ShaderMaterial.new()
#	dialboxRight.material.shader = Shader.new()
#	dialboxRight.material.shader.code = global.dialBoxShaderCode
#	dialboxRight.material.shader.set_default_texture_param('mask', load('res://images/dialoguebox/left.png'))
#	dialogueBox.add_child(dialboxRight)
#	dialboxLeft = ColorRect.new()
#	dialboxLeft.name = 'Dialogue Box Left'
#	dialboxLeft.color = Color.black
#	dialboxLeft.margin_bottom = 290
#	dialboxLeft.margin_top = 0
#	dialboxLeft.margin_left = 1110
#	dialboxLeft.margin_right = 1515
#	dialboxLeft.material = ShaderMaterial.new()
#	dialboxLeft.material.shader = Shader.new()
#	dialboxLeft.material.shader.code = global.dialBoxShaderCode
#	dialboxLeft.material.shader.set_default_texture_param('mask', load('res://images/dialoguebox/right.png'))
#	dialogueBox.add_child(dialboxLeft)
	
	# Load the dialogue RichTextLaabel under dialogueBox.
	dialogue = RichTextLabel.new();
	dialogue.name = 'Dialogue'
	dialogue.bbcode_enabled = true
	dialogue.margin_top = 80
	dialogue.margin_bottom = 245
	dialogue.margin_left = 455
	dialogue.margin_right = 1405
	dialogue.set_theme(global.textTheme)
	dialogue.set_script(load('res://code/dialogue.gd'))
	
	# Set the default font for dialogue.
	dialogue.add_font_override("normal_font", global.defaultFont)
	dialogue.add_font_override("bold_font", global.defaultFontBold)
	dialogue.add_font_override("italics_font", global.defaultFontItalic)
	dialogueBox.add_child(dialogue);
	
	# Load the Namteag under dialogueBox.
	nametag = Label.new();
	nametag.name = 'Nametag'
	nametag.valign = 1
	nametag.margin_top = 0
	nametag.margin_bottom = 70
	nametag.margin_left = 435
	nametag.margin_right = 650
	
#	# Set the default font for nametags.
	var defaultFontNametagDATA = DynamicFontData.new()
	defaultFontNametagDATA.font_path = 'res://fonts/Nametag/coolvetica/coolvetica rg.ttf'
	var defaultFontNametag = DynamicFont.new()
	defaultFontNametag.font_data = defaultFontNametagDATA
	defaultFontNametag.size = 45
	nametag.add_font_override("font", defaultFontNametag)
	dialogueBox.add_child(nametag);
	
	# Load the character timer under dialogueBox.
	timer = Timer.new()
	timer.name = 'Timer'
	timer.process_mode = 1
	timer.wait_time = 0.04
	timer.one_shot = false
	timer.autostart = true
	timer.connect("timeout", dialogue, "_on_Timer_timeout")
	dialogueBox.add_child(timer)
	
	dialogueBox.script = script
	canvas.add_child(dialogueBox)
	pauseCanvas.add_child(pause)