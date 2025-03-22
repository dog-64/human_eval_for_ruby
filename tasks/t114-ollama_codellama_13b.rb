def min_sub_array_sum(nums)
    return nil if nums.empty?

    sum = 0
    min_sum = Float::INFINITY
    start = 0
    end = 0

    while end < nums.size
        sum += nums[end]
        end += 1

        while sum > 0 && start < end
            sum -= nums[start]
            start += 1
        end

        min_sum = [min_sum, sum].min if sum > 0
    end

    return min_sum
end