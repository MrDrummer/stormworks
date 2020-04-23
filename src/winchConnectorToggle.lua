-- 4 connectors can can be independently toggled as well as a group toggle on/off input.
-- NOTE: 1-4 connector toggles have to be PULSED prior to input into this script.

Connectors = 4
ConnectorsState = {}

function setConnectorState(index, state)
  ConnectorsState[index] = state
  output.setBool(index, state)
end

function toggleConnectorState(index)
  connectorState = input.getBool(index)
  if connectorState then
    state = ConnectorsState[index]
    output.setBool(index, not state)
    setConnectorState(index, not state)
  end
end

function onTick()
  AllOn = input.getBool(31)
  AllOff = input.getBool(32)

  for i=1,Connectors do
    
    if AllOn then
      setConnectorState(i, true)
    elseif AllOff then
      setConnectorState(i, false)
    else
      toggleConnectorState(i)
    end
  end
end