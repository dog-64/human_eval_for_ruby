def prod_signs(arr)
    return nil if arr.empty?
    sum = 0
    product = 1
    arr.each do |x|
        sum += x.abs
        product *= (x > 0 ? 1 : -1)
    end
    return sum * product
end