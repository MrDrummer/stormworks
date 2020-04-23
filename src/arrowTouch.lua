

i1Toggled = false

i2Toggled = false

function onTick()
isP1 = input.getBool(1)
isP2 = input.getBool(2)

in1X = input.getNumber(3)
in1Y = input.getNumber(4)
in2X = input.getNumber(5)
in2Y = input.getNumber(6)
inVal = input.getNumber(7)
label = property.getText("Name")

if (isP1 and isInRect(3.75,8.25,24.5,5.75,in1X,in1Y)) or (isP2 and isInRect(3.75,8.25,24.5,5.75,in2X,in2Y)) then
i1Toggled=true
else
i1Toggled=false
end
output.setBool(1, i1Toggled)

if (isP1 and isInRect(4.25,25,23,6,in1X,in1Y)) or (isP2 and isInRect(4.25,25,23,6,in2X,in2Y)) then
i2Toggled=true
else
i2Toggled=false
end
output.setBool(2, i2Toggled)

end

function onDraw()

if i1Toggled then
setC(96,0,0)
else
setC(96,48,0)
end
cx=16
cy=11.125
angle=0
p1=rotatePoint(cx,cy,angle,3.75,14)
p2=rotatePoint(cx,cy,angle,16,8.25)
p3=rotatePoint(cx,cy,angle,28.25,14)
screen.drawTriangleF(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y)

if i2Toggled then
setC(96,0,0)
else
setC(96,48,0)
end
cx=15.75
cy=28
angle=3.14
p1=rotatePoint(cx,cy,angle,4.25,31)
p2=rotatePoint(cx,cy,angle,15.75,25)
p3=rotatePoint(cx,cy,angle,27.25,31)
screen.drawTriangleF(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y)

setC(0,48,96)
screen.drawRectF(0,15,32,8.75)
setC(0,0,0)
screen.drawRectF(1,16,30,6.75)
setC(0,48,96)
screen.drawTextBox(0, 15, 32, 8.75, inVal, 0, 0)

setC(0,48,96)
screen.drawRectF(0,0,32,7.25)
setC(0,0,0)
screen.drawRectF(1,1,30,5.25)
setC(0,48,96)
screen.drawTextBox(0, 0, 32, 7.25, label, 0, 0)
end

function setC(r,g,b,a)
if a==nil then a=255 end
screen.setColor(r,g,b,a)
end

function isInRect(x,y,w,h,px,py)
return px>=x and px<=x+w and py>=y and py<=y+h
end

function rotatePoint(cx,cy,angle,px,py)
s=math.sin(angle)
c=math.cos(angle)
px=px-cx
py=py-cy
xnew=px*c-py*s
ynew=px*s+py*c
px=xnew+cx
py=ynew+cy
return {x=px,y=py}
end

