Colours = {
	point = { 245, 135, 66 },
	activePoint = { 237, 189, 76 },
	pointLine = { 62, 115, 199 },
	currentPos = { 84, 235, 61 },
	otherPos = { 59, 237, 178 }
}

PanSpeed = 20


-- initial values
Waypoints = {}
WaypointCount = 0
ActiveWaypoint = 0

MapCenter = { X = 0, Y = 0 }

LastWaypoint = {
	pressed = false,
	pressedTick = false
}

NextWaypoint = {
	pressed = false,
	pressedTick = false
}

CurrentPos = {
	mapX = 0,
	mapY = 0,
	mapScreenX = 0,
	mapScreenY = 0
}

OtherPos = {
	mapX = 0,
	mapY = 0,
	mapScreenX = 0,
	mapScreenY = 0
}

ScreenInput1 = {
	inputX = 0,
	inputY = 0,
	pressed = 0,
	mapScreenX = 0,
	mapScreenY = 0
}

ScreenInput2 = {
	inputX = 0,
	inputY = 0,
	pressed = 0,
	mapScreenX = 0,
	mapScreenY = 0
}

function AddWaypoint(wp)
	-- Is a valid waypoint
	if wp.mapX ~= nil and wp.mapY ~= nil then
		wp.inputX = nil
		wp.inputY = nil
		table.insert(Waypoints, wp)
		WaypointCount = WaypointCount + 1
	end
end

function RenderPoint(point, colour, screen)
	if point ~= nil and point.mapX ~= nil and point.mapY ~= nil then
		point.mapScreenX, point.mapScreenY = map.mapToScreen(MapCenter.X, MapCenter.Y, ZoomLevel, S.W, S.H, point.mapX, point.mapY)
		screen.setColor(table.unpack(Colours[colour]))
		screen.drawCircleF(point.mapScreenX, point.mapScreenY, 3)
	end
end

function RenderLine(point1, point2, screen)

	if point1 ~= nil and point2 ~= nil and point1.mapX ~= nil and point1.mapY ~= nil and point2.mapX ~= nil and point2.mapY ~= nil then
		screen.setColor(table.unpack(Colours.pointLine))
		screen.drawLine(point1.mapScreenX, point1.mapScreenY, point2.mapScreenX, point2.mapScreenY)
	end
end

function onTick()
	ZoomLevel = input.getNumber(7)
	PanBy = ZoomLevel * PanSpeed
	CurrentPos.mapX = input.getNumber(8)
	CurrentPos.mapY = input.getNumber(9)

	OtherPos.mapX = 200
	OtherPos.mapY = 200

	-- otherPos = { X = input.getNumber(10), Y = input.getNumber(11) }

	ScreenInput1.inputX = input.getNumber(3)
	ScreenInput1.inputY = input.getNumber(4)
	ScreenInput1.pressed = input.getBool(1)

	ScreenInput2.inputX = input.getNumber(6)
	ScreenInput2.inputY = input.getNumber(7)
	ScreenInput2.pressed = input.getBool(2)

	PanLeft = input.getBool(3)
	PanRight = input.getBool(4)
	PanUp = input.getBool(5)
	PanDown = input.getBool(6)
	LastWaypoint.pressed = input.getBool(7)
	NextWaypoint.pressed = input.getBool(8)
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
		MapCenter.X = CurrentPos.mapX
		MapCenter.Y = CurrentPos.mapY
	elseif CenterOnOther then
		MapCenter.X = OtherPos.mapX
		MapCenter.Y = OtherPos.mapY

	elseif LastWaypoint.pressed == false and LastWaypoint.pressedTick == true then
		LastWaypoint.pressedTick = false
	elseif NextWaypoint.pressed == false and NextWaypoint.pressedTick == true then
		NextWaypoint.pressedTick = false

	elseif LastWaypoint.pressed and LastWaypoint.pressedTick == false then
		if ActiveWaypoint > 0 then ActiveWaypoint = ActiveWaypoint - 1 end
	elseif NextWaypoint.pressed and NextWaypoint.pressedTick == false then
		if ScreenInput1.inputX == nil then
			-- Has not selected the next position since spawning
			return
		end
		AddWaypoint( ScreenInput1 )
		ScreenInput1 = {}
		ActiveWaypoint = ActiveWaypoint + 1
	elseif ScreenInput1.pressed then
		ScreenInput1.mapX, ScreenInput1.mapY = map.screenToMap(MapCenter.X, MapCenter.Y, ZoomLevel, S.W, S.H, ScreenInput1.inputX, ScreenInput1.inputY)
	end
end

function onDraw()
	S = {
		W = screen.getWidth(),
		H = screen.getHeight()
	}

	screen.drawMap(MapCenter.X, MapCenter.Y, ZoomLevel)

	-- RenderLine(ScreenInput1, CurrentPos, screen)

	if WaypointCount >= 0 then
		RenderLine(CurrentPos, Waypoints[1], screen)
	end

	for index, point in ipairs(Waypoints) do
		local colour = "point"
		if index == ActiveWaypoint then
			colour = "activePoint"
		end
		
		-- NOT last item
		if index ~= WaypointCount then
			RenderLine(point, Waypoints[index + 1], screen)
		end
		
		RenderPoint(point, colour, screen)
	end

	if WaypointCount >= 0 and ScreenInput1 ~= nil then
		RenderLine(Waypoints[WaypointCount], ScreenInput1, screen)
	end

	RenderPoint(CurrentPos, "currentPos", screen)
	RenderPoint(OtherPos, "otherPos", screen)
	RenderPoint(ScreenInput1, "point", screen)
end