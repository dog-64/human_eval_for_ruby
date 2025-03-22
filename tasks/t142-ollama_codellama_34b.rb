def sum_squares(lst)
    result = 0
    lst.each_with_index do |element, index|
        if index % 3 == 0
            element **= 2
        elsif index % 4 == 0
            element **= 3
        end
        result += element
    end
    return result
end