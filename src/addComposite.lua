-- Take the first 16 channels of two composite inputs and add them together. Application is two pilot inputs. One can counter the other.

function onTick()
  for i=1,16 do
    pilot1 = input.getNumber(i)
    pilot2 = input.getNumber(i + 16)
    output.setNumber(i, pilot1 + pilot2)
  end
end