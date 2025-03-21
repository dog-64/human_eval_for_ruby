def move_one_ball(arr)
    return true if arr.empty?
    sorted = false
    until sorted
        sorted = true
        (arr.length - 1).times do |i|
            if arr[i] > arr[i + 1]
                arr[i], arr[i + 1] = arr[i + 1], arr[i]
                sorted = false
            end
        end
    end
    return true
end