Colours = {
	point = { 245, 135, 66 },
	activePoint = { 237, 189, 76 },
	pointLine = { 62, 115, 199 },
	currentPos = { 84, 235, 61 },
	otherPos = { 59, 237, 178 }
}

-- initial value
MapCenter = { X = 0, Y = 0 }
ScreenInput1 = { X = 0, Y = 0 }
ScreenInput2 = { X = 0, Y = 0 }
CurrentPos = { X = 0, Y = 0 }
OtherPos = { X = 0, Y = 0 }

PanSpeed = 20

Waypoints = {}

function onTick()
	ZoomLevel = input.getNumber(7)
	PanBy = ZoomLevel * PanSpeed

	CurrentPos = { X = input.getNumber(8), Y = input.getNumber(9) }
	OtherPos = { X = 200, Y = 200 }
	-- otherPos = { X =input.getNumber(10), Y = input.getNumber(11) }
	
	ScreenInput1 = { X = input.getNumber(3), Y = input.getNumber(4), pressed = input.getBool(1) }
	ScreenInput2 = { X = input.getNumber(6), Y = input.getNumber(7), pressed = input.getBool(2) }

	PanLeft = input.getBool(3)
	PanRight = input.getBool(4)
	PanUp = input.getBool(5)
	PanDown = input.getBool(6)
	LastWaypoint = input.getBool(7)
	NextWaypoint = input.getBool(8)
	CenterOnShip = input.getBool(9)
	CenterOnOther = input.getBool(10)

	if PanLeft then
		MapCenter.X = MapCenter.X - PanBy
	elseif PanRight then
		MapCenter.X = MapCenter.X + PanBy
	elseif PanUp then
		MapCenter.Y = MapCenter.Y + PanBy
	elseif PanDown then
		MapCenter.Y = MapCenter.Y - PanBy
	elseif CenterOnShip then
		MapCenter = CurrentPos
	elseif CenterOnOther then
		MapCenter = OtherPos
	elseif LastWaypoint then
		--
	elseif NextWaypoint then

	end
end

function onDraw()
	ScreenW = screen.getWidth()
	ScreenH = screen.getHeight()

	if CurrentPos.X and CurrentPos.Y then
		CurrentXPixel, CurrentYPixel = map.mapToScreen(MapCenter.X, MapCenter.Y, ZoomLevel, ScreenW, ScreenH, CurrentPos.X, CurrentPos.Y)
	end

	screen.drawMap(MapCenter.X, MapCenter.Y, ZoomLevel)
	screen.setColor(245, 135, 66)
	screen.drawCircleF(CurrentXPixel, CurrentYPixel, 3)
	screen.setColor(255, 0, 0)
	screen.drawCircleF(ScreenInput1.X, ScreenInput1.Y, 3)
end