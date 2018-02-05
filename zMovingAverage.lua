Settings = {
  Name = "* Moving Average (simple)",
  Period = 13,
  VShift = 0,
  line = {
    {
      Name = "MA",
      Type = TYPE_LINE, 
      Color = RGB(255, 127, 127)
		}
  }
}

function Init() 
	ma = MA()
	return #Settings.line
end

function OnCalculate(index) 
	return ma(index, Settings)
end

function MA() -- Moving Average ("MA")
  local _ma = SMA()
  return function(i, settings)
    local result = nil
    local period = (settings.Period or 13)
    if period < 1 then period = 1 end
    local vshift = (settings.VShift or 0)
    return _ma(i, period, vshift)
  end
end

------------------------------------------------------------------
-- Moving Average SMA
------------------------------------------------------------------
--[[--
  Simple Moving Average (SMA)
  SMA = sum(Pi) / n
--]]--

function SMA()
  return function(index, period, vshift) 
    local result = nil
    if index >= period then
      local sum = 0
      for i = index-period+1, index do
        sum = sum + (C(i) or 0)
      end
      result = sum/period + vshift
    end 
    return result
  end
end
