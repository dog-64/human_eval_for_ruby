def get_max_triples(n)
  a = (1..n).map { |i| i * i - i + 1 }
  triples = []
  (0...a.length-2).each do |i|
    j = i + 1
    k = i + 2
    if a[i] % 3 == 0 && a[j] % 3 == 0 && a[k] % 3 == 0
      triples << [a[i], a[j], a[k]]
    end
  end
  return triples.length
end