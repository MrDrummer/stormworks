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
WaypointCount = 0
SelectedWaypoint = 0

function AddWaypoint(wp)
	-- Is a valid waypoint
	if wp.X ~= nil and wp.Y ~= nil then
		table.insert(Waypoints, wp)
		WaypointCount = WaypointCount + 1
	end
end

function onTick()
	ZoomLevel = input.getNumber(7)
	PanBy = ZoomLevel * PanSpeed
	CurrentPos = {
		X = input.getNumber(8),
		Y = input.getNumber(9),
		mapScreenX = 0,
		mapScreenY = 0
	}

	OtherPos = {
		X = 200,
		Y = 200,
		mapScreenX = 0,
		mapScreenY = 0
	}
	-- otherPos = { X =input.getNumber(10), Y = input.getNumber(11) }

	ScreenInput1 = {
		inputX = input.getNumber(3),
		inputY = input.getNumber(4),
		pressed = input.getBool(1),
		mapX = 0,
		mapY = 0,
		mapScreenX = 0,
		mapScreenY = 0
	}

	ScreenInput2 = {
		inputX = input.getNumber(6),
		inputY = input.getNumber(7),
		pressed = input.getBool(2),
		mapX = 0,
		mapY = 0,
		mapScreenX = 0,
		mapScreenY = 0
	}

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
		-- NEED TO HAVE TOGGLE ON TOGGLE OFF OTHERWISE PRESSING AND HOLDING WILL KEEP ADDING TO THE TABLE!!!!
	elseif NextWaypoint then
		-- NEED TO HAVE TOGGLE ON TOGGLE OFF OTHERWISE PRESSING AND HOLDING WILL KEEP ADDING TO THE TABLE!!!!
		if ScreenInput1.inputX == nil then
			-- Has not selected the next position since spawning
			return
		end
		-- NEED TO HAVE TOGGLE ON TOGGLE OFF OTHERWISE PRESSING AND HOLDING WILL KEEP ADDING TO THE TABLE!!!!
		AddWaypoint( ScreenInput1 )
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

	-- Current position rendered on the map
	if CurrentPos.X ~= nil and CurrentPos.Y ~= nil then
		CurrentPos.mapScreenX, CurrentPos.mapScreenY = map.mapToScreen(MapCenter.X, MapCenter.Y, ZoomLevel, S.W, S.H, CurrentPos.X, CurrentPos.Y)
		screen.setColor(table.unpack(Colours.currentPos))
		screen.drawCircleF(CurrentPos.mapScreenX, CurrentPos.mapScreenY, 3)
	end
	
	-- Other position rendered on the map
	if OtherPos.X ~= nil and OtherPos.Y ~= nil then
		OtherPos.mapScreenX, OtherPos.mapScreenY = map.mapToScreen(MapCenter.X, MapCenter.Y, ZoomLevel, S.W, S.H, OtherPos.X, OtherPos.Y)
		screen.setColor(table.unpack(Colours.OtherPos))
		screen.drawCircleF(OtherPos.mapScreenX, OtherPos.mapScreenY, 3)
	end

	-- Input 1 position rendered on the map
	if ScreenInput1.X ~= nil and ScreenInput1.Y ~= nil then
		ScreenInput1.mapScreenX, ScreenInput1.mapScreenY = map.mapToScreen(MapCenter.X, MapCenter.Y, ZoomLevel, S.W, S.H, ScreenInput1.mapX, ScreenInput1.mapY)
		screen.setColor(table.unpack(Colours.activePoint))
		screen.drawCircleF(ScreenInput1.mapScreenX, ScreenInput1.mapScreenY, 3)
	end




	-- if ScreenInput1.inputX ~= nil then
	-- 	screen.setColor(table.unpack(Colours.pointLine))
	-- end
end