def get_max_triples(n)
  a = (1..n).map { |i| i * i - i + 1 }
  count = 0
  (n - 2).times do |i|
    (i + 1).upto(n - 1) do |j|
      (j + 1).upto(n) do |k|
        if (a[i] + a[j] + a[k]) % 3 == 0
          count += 1
        end
      end
    end
  end
  count
end