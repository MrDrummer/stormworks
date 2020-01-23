Colours = {
	point = { 245, 135, 66 },
	activePoint = { 242, 64, 15 },
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
	pressed = false,
	mapScreenX = 0,
	mapScreenY = 0
}

ScreenInput2 = {
	inputX = 0,
	inputY = 0,
	pressed = false,
	mapScreenX = 0,
	mapScreenY = 0
}

RemoveFirstWaypoint = {
	pressed = false,
	pressedTick = false
}

RemoveActiveWaypoint = {
	pressed = false,
	pressedTick = false
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

function RemoveWaypoint(index)
	table.remove(Waypoints, index)
	DecreaseBy(WaypointCount, 1)

	if ActiveWaypoint > WaypointCount then
		ActiveWaypoint = WaypointCount
	end
end

function IncreaseBy(value, by)
	return value + by
end

function DecreaseBy(value, by)
	return value - by
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
	if ActiveWaypoint < 0 then
		ActiveWaypoint = 0
	end

	if ActiveWaypoint > WaypointCount then
		ActiveWaypoint = WaypointCount
	end

	-- if WaypointCount > 0 then
	-- 	output.setNumber(1, Waypoints[1].mapX)
	-- 	output.setNumber(2, Waypoints[1].mapY)
	-- end

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
	RemoveFirstWaypoint.pressed = input.getBool(11)
	RemoveActiveWaypoint.pressed = input.getBool(12)

	output.setNumber(3, ActiveWaypoint)
	output.setNumber(4, WaypointCount)

	if PanLeft then
		IncreaseBy(MapCenter.X, PanBy)
	elseif PanRight then
		DecreaseBy(MapCenter.X, PanBy)
	elseif PanUp then
		IncreaseBy(MapCenter.Y, PanBy)
	elseif PanDown then
		DecreaseBy(MapCenter.Y, PanBy)

	elseif CenterOnShip then
		MapCenter.X = CurrentPos.mapX
		MapCenter.Y = CurrentPos.mapY
	elseif CenterOnOther then
		MapCenter.X = OtherPos.mapX
		MapCenter.Y = OtherPos.mapY

	elseif not LastWaypoint.pressed and LastWaypoint.pressedTick then
		LastWaypoint.pressedTick = false
	elseif not NextWaypoint.pressed and NextWaypoint.pressedTick then
		NextWaypoint.pressedTick = false
	elseif not RemoveFirstWaypoint.pressed and RemoveFirstWaypoint.pressedTick then
		RemoveFirstWaypoint.pressedTick = false
	elseif not RemoveActiveWaypoint.pressed and RemoveActiveWaypoint.pressedTick then
		RemoveActiveWaypoint.pressedTick = false

	elseif RemoveFirstWaypoint.pressed and not RemoveFirstWaypoint.pressedTick then
		RemoveWaypoint(1)
		RemoveFirstWaypoint.pressedTick = true

	elseif RemoveActiveWaypoint.pressed and not RemoveActiveWaypoint.pressedTick then
		RemoveWaypoint(ActiveWaypoint)
		RemoveActiveWaypoint.pressedTick = true

	elseif LastWaypoint.pressed and not LastWaypoint.pressedTick then
		LastWaypoint.pressedTick = true
		if ActiveWaypoint > 0 then
			DecreaseBy(ActiveWaypoint, 1)
		end
	elseif NextWaypoint.pressed and not NextWaypoint.pressedTick then
		NextWaypoint.pressedTick = true
		if ScreenInput1.inputX == 0 and ScreenInput1.inputY == 0 then
			-- Has not selected the next position since spawning
			return
		end

		-- last waypoint or no waypoint is selected
		if ActiveWaypoint == WaypointCount then
			AddWaypoint( ScreenInput1 )
			ScreenInput1 = {}
		elseif ActiveWaypoint < WaypointCount then

		else
			return
		end
		ActiveWaypoint = ActiveWaypoint + 1
		IncreaseBy(ActiveWaypoint, 1)
	elseif ScreenInput1.pressed then
		ScreenInput1.mapX, ScreenInput1.mapY = map.screenToMap(MapCenter.X, MapCenter.Y, ZoomLevel, S.W, S.H, ScreenInput1.inputX, ScreenInput1.inputY)
	end

	-- Not the last waypoint
	if ScreenInput1.pressed and ActiveWaypoint < WaypointCount then
		Waypoints[ActiveWaypoint].mapX = ScreenInput1.mapX
		Waypoints[ActiveWaypoint].mapY = ScreenInput1.mapY
		ScreenInput1 = {}
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

	RenderPoint(CurrentPos, "currentPos", screen)
	RenderPoint(OtherPos, "otherPos", screen)
	RenderPoint(ScreenInput1, "point", screen)
end
