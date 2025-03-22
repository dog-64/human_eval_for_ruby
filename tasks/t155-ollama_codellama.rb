def even_odd_count(num)
    count = num.to_s.chars.map { |c| c.to_i }
    even = count.select { |c| c % 2 == 0 }.length
    odd = count.select { |c| c % 2 != 0 }.length
    [even, odd]
end