-- 245, 135, 66 waypoint red
-- 19, 65, 138 line blue

mapCenter = {}
mapCenter.X = 0
mapCenter.Y = 0

panRelative = 20

function onTick()
	screenInput1X = input.getNumber(3)
	screenInput1Y = input.getNumber(4)
	screenInput2X = input.getNumber(5)
	screenInput2Y = input.getNumber(6)
	zoomLevel = input.getNumber(7)
	panBy = zoomLevel * panRelative
	currentX = input.getNumber(8)
	currentY = input.getNumber(9)
	otherX = 200 -- input.getNumber(10)
	otherY = 200 -- input.getNumber(11)
	panLeft = input.getBool(3)
	panUp = input.getBool(4)
	panDown = input.getBool(5)
	panRight = input.getBool(6)
	centerOnShip = input.getBool(9)
	centerOnOther = input.getBool(10)

	if panLeft then
		local x = mapCenter.X
		mapCenter.X = x - panBy
	elseif panRight then
		local x = mapCenter.X
		mapCenter.X = x + panBy
	elseif panUp then
		local y = mapCenter.Y
		mapCenter.Y = y - panBy
	elseif panDown then
		local y = mapCenter.Y
		mapCenter.Y = y + panBy
	elseif centerOnShip then
		mapCenter.X = currentX
		mapCenter.Y = currentY
	elseif centerOnOther then
		mapCenter.X = otherX
		mapCenter.Y = otherY
	end

	waypoints = {}
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	screen.drawMap(mapCenter.X, mapCenter.Y, zoomLevel)
	screen.setColor(245, 135, 66)
	screen.drawCircleF(currentX, currentY, 3)
	-- screen.setColor(255, 0, 0)
	-- screen.drawCircleF(screenInput1X, screenInput1Y, 3)
end