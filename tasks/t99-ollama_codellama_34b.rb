
def closest_integer(value)
    value = Float(value)
    rounded_up = (value + 0.5).floor
    rounded_down = (value - 0.5).ceil
    if (rounded_up - value).abs < (value - rounded_down).abs
        return rounded_up
    else
        return rounded_down
    end
end