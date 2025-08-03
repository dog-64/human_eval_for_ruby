
def pluck(arr)
  min_value = nil
  min_index = nil

  arr.each_with_index do |num, index|
    if num.even?
      if min_value.nil? || num < min_value
        min_value = num
        min_index = index
      end
    end
  end

  min_value.nil? ? [] : [min_value, min_index]
end