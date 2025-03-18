def odd_count(strings)
  result = []
  strings.each do |str|
    count = str.count(&:odd?)
    result << "the number of odd elements #{count}n the str#{count}ng #{count} of the #{count}nput."
  end
  result
end