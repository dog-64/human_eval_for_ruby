def intersperse(numbers, delimeter)
  numbers.each_with_index.map { |number, index| index.even? ? number : [number, delimeter] }.flatten(keep_blank_characters: true)
end