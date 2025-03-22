def get_max_triples(n)
  a = (1..n).map { |i| i * i - i + 1 }
  triples = []
  (0...a.length-2).each do |i|
    j = i + 1
    k = i + 2
    while j < k && a[j] + a[k] <= a[i]
      j += 1
      k += 1
    end
    triples << [a[i], a[j], a[k]] if j < k && (a[j] + a[k]) % 3 == 0
  end
  triples.length
end