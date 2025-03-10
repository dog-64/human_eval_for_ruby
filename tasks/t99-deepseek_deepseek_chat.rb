def closest_integer(value)
    num = value.to_f
    if num == num.floor + 0.5
        num > 0 ? num.ceil : num.floor
    else
        num.round
    end
end