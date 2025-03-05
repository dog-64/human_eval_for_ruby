def get_max_triples(n)
  return 0 if n < 3

  a = (0...n).map { |i| i * i - i + 1 }
  count = 0

  (0...n - 2).each do |i|
    (i + 1...n - 1).each do |j|
      (j + 1...n).each do |k|
        count += 1 if (a[i] + a[j] + a[k]) % 3 == 0
      end
    end
  end

  count
end