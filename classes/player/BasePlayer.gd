class_name BasePlayer extends RigidBody2D

var speed = 200.0
var max_speed = Vector2(100,100)

export var engine_thrust:int
export var spin_thrust:float

var thrust = Vector2()
var move_direction = 0
var velocity = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func get_input():
#	if abs(self.linear_velocity.x) <= self.max_speed.x and abs(self.linear_velocity.y) <= self.max_speed.y:
	if Input.is_action_pressed("move_up"):
		print("teretet")
		self.thrust = Vector2(0, -self.engine_thrust)
	if Input.is_action_pressed("move_down"):
		self.thrust = Vector2(0, self.engine_thrust)
		
	self.move_direction = 0
		
	if Input.is_action_pressed("move_left"):
		self.move_direction -= 1
	if Input.is_action_pressed("move_right"):
		self.move_direction += 1
		
	pass

func _process(delta):
	self.get_input()
	pass

func _physics_process(delta):
#	print("Velocity: " + str(self.linear_velocity))

#	self.apply_central_impulse (Vector2(0, 0))
	
#	self.add_force(Vector2(0,0), (self.move_direction * speed) * delta)
	
	if (abs(self.linear_velocity.x) <= self.max_speed.x and abs(self.linear_velocity.y) <= self.max_speed.y):
		self.add_central_force(self.thrust.rotated(self.rotation))
		self.linear_damp = 10
	else:
		self.velocity = lerp(self.linear_velocity.x, 0, 1)
		print("else Velocity: " + str(self.linear_velocity) + " vel: " + str(self.velocity))
		self.add_central_force(Vector2(self.velocity,0))
	
	rotation += self.move_direction * self.spin_thrust * delta
#	self.add_torque(self.move_direction * self.spin_thrust)

	pass
