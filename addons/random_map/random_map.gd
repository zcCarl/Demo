extends Node2D
class_name CellularAutomata
var width = 200;
var height = 200;
var tiles = []
var maps = []
var perl = []
var _perlin:perlin

@onready var tile_map:TileMap = $TileMap
func _ready():
	_perlin = perlin.new()
	var random = RandomNumberGenerator.new();
	var walls = CellularAutomata.Generate(width, height,4,20);
	for y in range(1,height-1):
		for x in range(1,width-1):
			if walls[x + y * width]:
				#tiles[x + y * width] = '#' 
				maps.append(Vector2i(x,y))
				var hei = _perlin.octave_perlin(x/200.0,y/200.0,0,4,64)
				hei = floorf(floorf(hei * 100)/10)
				print(hei)
				for i in range(hei,1, -1):
					var offset =  hei - i
					var rx = x + offset
					var ry = y + offset
					rx = clampi(rx,1,width)
					ry = clampi(ry,1,height)
					tile_map.set_cell(i,Vector2i(rx,ry),4,Vector2i(1,0),0)
			tile_map.set_cell(0,Vector2i(x,y),4,Vector2i(1,0),0)
	pass

func _process(delta):
	pass

static func Generate(width:int , height:int ,iterations:int = 4,percentAreWalls :int =40):
	var map  = {}
	RandomFill(map, width, height, percentAreWalls)
	for i in range(0,iterations):
		map = Step(map, width, height)
	return map
static func RandomFill(map,width:int , height:int ,percentAreWalls :int =40):
	var random = RandomNumberGenerator.new();
	var randomColumn = random.randi_range(4 , width - 4 )
	for y in range(0,height):
		for x in range(0,width):
			if(x == 0 || y == 0 || x == width - 1 || y == height - 1):
				map[x + y * width] = true
			elif x != randomColumn && random.randi_range(0,100) < percentAreWalls :
				map[x + y * width] = true
			else :
				map[x + y * width] = false
	pass
static func Step(map, width, height):
	var newMap = {}
	for  y in  range(0,height):
		for x in  range(0,width):
			if x == 0 || y == 0 || x == width - 1 || y == height - 1:
				newMap[x + y * width] = true;
			else:
				newMap[x + y * width] = PlaceWallLogic(map, width, height, x, y);
	return newMap;
	pass

static func PlaceWallLogic(map, width:int, height:int,x:int,y:int)->bool:
	return CountAdjacentWalls(map, width, height, x, y) >= 5 || CountNearbyWalls(map, width, height, x, y) <= 2;
static func CountAdjacentWalls(map, width:int, height:int,x:int,y:int)->int:
	var walls = 0
	for mapX in range(x - 1,x + 1):
		for mapY in range(y - 1,y + 1):
			if map[mapX + mapY * width]:
				walls += 1
	return walls

static func CountNearbyWalls(map, width:int, height:int,x:int,y:int)->int:
	var walls = 0
	for mapX in range(x - 2,x + 2):
		for mapY in range(y - 2,y + 2):
			if abs(mapX - x) == 2 && abs(mapY - y) == 2:
				continue
			if mapX < 0 || mapY < 0 || mapX >= width || mapY >= height:
				continue
			if map[mapX + mapY * width]:
				walls += 1
	return walls

class perlin :
	const permutation:Array = [151,160,137,91,90,15,					# Hash lookup table as defined by Ken Perlin.  This is a randomly
		131,13,201,95,96,53,194,233,7,225,140,36,103,30,69,142,8,99,37,240,21,10,23,	# arranged array of all numbers from 0-255 inclusive.
		190, 6,148,247,120,234,75,0,26,197,62,94,252,219,203,117,35,11,32,57,177,33,
		88,237,149,56,87,174,20,125,136,171,168, 68,175,74,165,71,134,139,48,27,166,
		77,146,158,231,83,111,229,122,60,211,133,230,220,105,92,41,55,46,245,40,244,
		102,143,54, 65,25,63,161, 1,216,80,73,209,76,132,187,208, 89,18,169,200,196,
		135,130,116,188,159,86,164,100,109,198,173,186, 3,64,52,217,226,250,124,123,
		5,202,38,147,118,126,255,82,85,212,207,206,59,227,47,16,58,17,182,189,28,42,
		223,183,170,213,119,248,152, 2,44,154,163, 70,221,153,101,155,167, 43,172,9,
		129,22,39,253, 19,98,108,110,79,113,224,232,178,185, 112,104,218,246,97,228,
		251,34,242,193,238,210,144,12,191,179,162,241, 81,51,145,235,249,14,239,107,
		49,192,214, 31,181,199,106,157,184, 84,204,176,115,121,50,45,127, 4,150,254,
		138,236,205,93,222,114,67,29,24,72,243,141,128,195,78,66,215,61,156,180]
	
	var p :Array = []
	func _init():
		p = []
		for x in range(512):
			p.append(permutation[x%256])
			
	func octave_perlin(x:float , y:float , z:float , octaves:int , persistence:float)->float:
		var total:float = 0
		var frequency:float = 1
		var amplitude:float = 1
		var maxValue:float = 0			# Used for normalizing result to 0.0 - 1.0
		for i in range(octaves):
			total += perlin(x * frequency, y * frequency, z * frequency) * amplitude;	
			maxValue += amplitude;
			amplitude *= persistence;
			frequency *= 2;
		return total/maxValue;
	func perlin(x:float,y:float,z:float)->float:
#		var xi:int = int(x)&255
#		var yi:int = int(y)&255
#		var zi:int = int(z)&255
#		var xf:float = x - int(x)
#		var yf:float = y - int(y)
#		var zf:float = z - int(z)
		
		var xi:int = (int(floori(x) % 256) + 256) % 256;
		var yi:int = (int(floori(y) % 256) + 256) % 256;
		var zi:int = (int(floori(z) % 256) + 256) % 256;

		var xf:float = x - int(x);                             # We also fade the location to smooth the result.
		if (x < 0):
			xf = 1 + xf;
		var yf:float = y - int(y);
		if (y < 0):
			yf = 1 + yf;
		var zf:float = z - int(z);
		if (z < 0):
			zf = 1 + zf;
		
		var u:float = fade(xf);
		var v:float = fade(yf);
		var w:float = fade(zf);
		
		var a:int =  p[xi]     + yi
		var aa:int = p[a]      + zi;
		var ab:int = p[a + 1]  + zi;	
		var b:int =  p[xi + 1] + yi;	
		var ba:int = p[b]      + zi;
		var bb:int = p[b + 1]  + zi;
		
		
		var x1:float = lerp(	grad (p[aa], xf  , yf  , zf),				# The gradient function calculates the dot product between a pseudorandom
					grad (p[ba], xf-1, yf  , zf),				# gradient vector and the vector from the input coordinate to the 8
					u);										# surrounding points in its unit cube.
		var x2:float = lerp(	grad (p[ab], xf  , yf-1, zf),				# This is all then lerped together as a sort of weighted average based on the faded (u,v,w)
					grad (p[bb], xf-1, yf-1, zf),				# values we made earlier.
					  u);
		var y1:float = lerp(x1, x2, v);

		x1 = lerp(	grad (p[aa + 1], xf  , yf  , zf-1),
					grad (p[ba + 1], xf-1, yf  , zf-1),
					u);
		x2 = lerp(	grad (p[ab + 1], xf  , yf-1, zf-1),
				  	grad (p[bb + 1], xf-1, yf-1, zf-1),
				  	u);
		var y2:float = lerp (x1, x2, v);
		
		return (lerp (y1, y2, w)+1)/2						# For convenience we bound it to 0
		pass
	func grad(hash:int, x:float, y:float, z:float)->float:
		var h:int = hash & 5
		var u:float = x if h < 8 else y #0b1000
		var v:float 
		if h < 4: #0b0100
			v = y
		elif h == 12 || h == 14:
			v = x
		else:
			v = z
		return (u if h&1 == 0 else -u) + (v if h&2 == 0 else -v)
		
	func fade(t:float)->float:
		return t * t * t * (t * (t * 6 - 15) + 10)
	func lerp(a:float, b:float, x:float)->float:
		return a + x * (b - a)
