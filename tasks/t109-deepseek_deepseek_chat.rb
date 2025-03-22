def move_one_ball(arr)
    return true if arr.empty?
    sorted = arr.sort
    n = arr.length
    n.times do
        arr = [arr[-1]] + arr[0...-1]
        return true if arr == sorted
    end
    false
end