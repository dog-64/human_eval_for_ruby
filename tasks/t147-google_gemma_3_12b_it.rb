def get_max_triples(n)
  return 0 if n < 3
  a = (1..n).map { |i| i * i - i + 1 }
  count = 0
  (0...n).each do |i|
    (i + 1...n).each do |j|
      (j + 1...n).each do |k|
        if (a[i] + a[j] + a[k]) % 3 == 0
          count += 1
        end
      end
    end
  end
  count
end
