def get_max_triples(n)
  a = []
  (1..n).each do |i|
    a << i * i - i + 1
  end

  count = 0
  (0..n - 3).each do |i|
    (i + 1..n - 2).each do |j|
      (j + 1..n - 1).each do |k|
        if (a[i] + a[j] + a[k]) % 3 == 0
          count += 1
        end
      end
    end
  end

  count
end
