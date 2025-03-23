
def common(l1, l2)
  common_elements = []
  l1.each do |element|
    if l2.include?(element) && !common_elements.include?(element)
      common_elements << element
    end
  end
  common_elements.sort
end
