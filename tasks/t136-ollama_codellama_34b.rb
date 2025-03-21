def largest_smallest_integers(lst)
    max = nil
    min = nil
    lst.each do |x|
        if x < 0 and (max.nil? or x > max)
            max = x
        end
        if x > 0 and (min.nil? or x < min)
            min = x
        end
    end
    return [max, min]
end