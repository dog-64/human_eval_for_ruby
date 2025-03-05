def even_odd_count(num)
    digits = num.abs.to_s.chars
    even = digits.count { |d| d.to_i.even? }
    odd = digits.size - even
    [even, odd]
end


def even_odd_count(num)
    digits = num.abs.to_s.chars
    even_count = digits.count { |d| d.to_i.even? }
    odd_count = digits.size - even_count
    [even_count, odd_count]
end

def even_odd_count(num)
    digits = num.abs.to_s.chars
    even = digits.count { |d| d.to_i.even? }
    odd = digits.size - even
    [even, odd]
end

def even_odd_count(num)
    digits = num.abs.to_s.chars
    even_count = digits.count { |d| d.to_i.even? }
    odd_count = digits.size - even_count
    [even_count, odd_count]
end