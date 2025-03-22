def eat(number, need, remaining)
    required = need - number
    if required <= 0
        total_eaten = number
        carrots_left = remaining
    else
        if remaining >= required
            total_eaten = number + required
            carrots_left = remaining - required
        else
            total_eaten = number + remaining
            carrots_left = 0
        end
    end
    [total_eaten, carrots_left]
end