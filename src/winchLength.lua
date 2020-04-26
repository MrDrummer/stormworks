-- Control the length of 4 winches independently or at the same time.
-- Uses 5 buttons to determine what value to change then a keypad to set the desired value.

OldKeypadValue = 0
OldKeypadChanged = false
OldExecute = false
OldAllWinches = false
Winches = 4

IndependentControlButtonToggles = {}
AllWinches = false

function onTick()
  KeypadValue = input.getNumber(1)
  KeypadChanged = OldKeypadValue ~= KeypadValue

  AllWinches = input.getBool(32)
  AllWinchesChanged = OldAllWinches ~= AllWinches

  for i=1,Winches do
    lastValue = IndependentControlButtonToggles[i]
    IndependentControlButtonToggles[i] = input.getBool(i)

    -- Button selection has changed
    if KeypadChanged == true then
      if AllWinchesChanged == true then
        output.setNumber(i, KeypadValue)
        OldAllWinches = AllWinches
      end
      if lastValue ~= IndependentControlButtonToggles[i] then
        IndependentControlButtonToggles[i] = KeypadValue
        output.setNumber(i, KeypadValue)
      end
      OldKeypadChanged = KeypadChanged
    end
  end
end