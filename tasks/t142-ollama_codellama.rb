def sum_squares(lst)
    result = 0
    lst.each_with_index do |element, index|
        if index % 3 == 0
            result += element ** 2
        elsif index % 4 == 0 && !(index % 3 == 0)
            result += element ** 3
        else
            result += element
        end
    end
    return result
end