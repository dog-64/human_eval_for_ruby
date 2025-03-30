
def sort_third(l)
  return [] if l.empty?

  elements = l.each_with_index.select { |_, i| i % 3 == 0 }.map(&:first)
  sorted = elements.sort

  index = 0
  result = []
  l.each_with_index do |x, i|
    result << sorted[index] if i % 3 == 0
    result << x unless i % 3 == 0
    index += 1 if i % 3 == 0
  end

  result
end

 