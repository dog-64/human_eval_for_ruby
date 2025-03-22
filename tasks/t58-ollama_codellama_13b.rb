def common(l1, l2)
  return [] if l1.empty? || l2.empty?

  unique_elements = Set.new

  l1.each do |element|
    next unless l2.include?(element)
    unique_elements << element
  end

  l2.each do |element|
    next unless l1.include?(element)
    unique_elements << element
  end

  return unique_elements.to_a.sort
end