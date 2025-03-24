def get_max_triples(n)
  return 0 if n < 3
  a = (0..n-1).map { |i| i**2 - i + 1 }
  count = 0
  (0...n).combinations(3) do |i, j, k|
    count += 1 if (a[i] + a[j] + a[k]) % 3 == 0
  end
  count
end