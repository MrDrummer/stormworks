-- Clamp every number channel in composite between two values
Clamp = 1
LowerClamp = Clamp * -1

function onTick()
  for i=1,16 do
    channelValue = input.getNumber(i)
    if channelValue > Clamp then
      channel = 1
    elseif channelValue < LowerClamp then
      channel = -1
    end
    output.setNumber(i, channelValue)
  end
end