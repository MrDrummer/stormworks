-- Tick function that will be executed every logic tick
function onTick()
	value = input.getNumber(1)			 -- Read the first number from the script's composite input
	output.setNumber(1, value * 10)		-- Write a number to the script's composite output
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	screen.setColor(0, 255, 0)			 -- Set draw color to green
	screen.drawCircleF(w / 2, h / 2, 30)   -- Draw a 30px radius circle in the center of the screen
end