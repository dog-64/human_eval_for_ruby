def common(l1, l2)
  return [] if l1.empty? || l2.empty?

  unique_elements = Set.new
  l1.each { |element| unique_elements << element }
  l2.each { |element| unique_elements << element }

  common_elements = []
  unique_elements.each do |element|
    if l1.include?(element) && l2.include?(element)
      common_elements << element
    end
  end

  return common_elements.sort
end