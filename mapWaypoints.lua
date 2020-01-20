-- 245, 135, 66 waypoint red
-- 19, 65, 138 line blue

center = {}
center["X"] = currentX
center["Y"] = currentY

function onTick()
	screenInput1X = input.getNumber(3)
	screenInput1Y = input.getNumber(4)
	screenInput2X = input.getNumber(5)
	screenInput2Y = input.getNumber(6)
	zoomLevel = input.getNumber(7)
	currentX = input.getNumber(8)
	currentY = input.getNumber(9)
	otherX = 200 -- input.getNumber(10)
	otherY = 200 -- input.getNumber(11)
	centerOnShip = input.getBool(9)
	centerOnOther = input.getBool(10)

	if centerOnShip then
		center["X"] = currentX
		center["Y"] = currentY
	elseif centerOnOther then
		center["X"] = otherX
		center["Y"] = otherY
	end

	waypoints = {}
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	screen.drawMap(center.X, center.Y, zoomLevel)
	screen.setColor(245, 135, 66)
	screen.drawCircleF(screenInput1X, screenInput1Y, 3)
	screen.setColor(19, 65, 138)
	screen.drawCircleF(currentX, currentY, 3)
end