

def order_by_points(nums)
  return [] if nums.empty?

  arr = nums.map do |num|
    n = num.abs
    sum = 0
    while n > 0
      sum += n % 10
      n /= 10
    end
    [num, sum]
  end

  sorted_arr = arr.sort_by { |num, sum| [sum, num] }
  sorted_arr.map { |num, sum| num }
end