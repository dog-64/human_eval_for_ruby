def min_sub_array_sum(nums)
    return nil if nums.empty?

    sum = 0
    min_sum = Float::INFINITY
    start = 0
    end = 0

    while end < nums.size
        sum += nums[end]
        end += 1

        while sum < 0
            sum -= nums[start]
            start += 1
        end

        min_sum = [min_sum, sum].min
    end

    return min_sum
end
min_sub_array_sum([2, 3, 4, 1, 2, 4]) == 1
min_sub_array_sum([-1, -2, -3]) == -6
min_sub_array_sum([1]) == 1
min_sub_array_sum([5, -1, 2, -3]) == -3