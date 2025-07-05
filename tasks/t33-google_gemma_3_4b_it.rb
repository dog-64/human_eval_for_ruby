def sort_third(l)
  l_prime = []
  l.each_with_index do |element, index|
    if (index + 1) % 3 == 0
      l_prime << l[index + 1]
    else
      l_prime << element
    end
  end
  l_prime
end
