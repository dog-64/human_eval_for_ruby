
def count_nums(arr)
    arr.count { |n| n.digits.sum > 0 }
end