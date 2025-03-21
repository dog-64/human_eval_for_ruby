
def starts_one_ends(n)
    count = 0
    (1..9).each do |i|
        count += 1 if i % 10 == 1 || i / 10 == 1
    end
    count *= 2 unless n == 1
    count
end