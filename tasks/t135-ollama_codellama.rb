def can_arrange(arr)
    return -1 if arr.empty?
    arr.each_with_index do |element, index|
        if element < arr[index - 1]
            return index - 1
        end
    end
    return -1
end