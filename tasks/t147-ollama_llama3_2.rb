def get_max_triples(n)
  return 0 if n < 3
  a = Array.new(n) { |i| i * i - i + 1 }
  count = 0
  (n - 1).times do |i|
    (i + 1).upto(n - 2) do |j|
      (j + 1).upto(n - 1) do |k|
        next if a[i] % 3 != 0 || a[j] % 3 != 0 || a[k] % 3 != 0
        count += 1
      end
    end
  end
  count
end