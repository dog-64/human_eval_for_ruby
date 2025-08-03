
def sort_third(l)
  third_elements = l.select.with_index { |_, i| i % 3 == 0 }.sort
  result = []
  j = 0
  l.each_with_index do |elem, i|
    if i % 3 == 0
      result << third_elements[j]
      j += 1
    else
      result << elem
    end
  end
  result
end