
def get_max_triples(n)
    return 0 if n < 3
    a = []
    (1..n).each do |i|
        a << i * i - i + 1
    end
    count = 0
    (0...a.length-2).each do |i|
        ((i+1)...a.length-1).each do |j|
            ((j+1)...a.length).each do |k|
                if a[i] + a[j] + a[k] % 3 == 0
                    count += 1
                end
            end
        end
    end
    return count
end