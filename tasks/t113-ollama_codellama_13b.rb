def odd_count(strings)
  result = []
  strings.each do |string|
    count = string.count("1") % 2 == 0 ? "even" : "odd"
    result << "the number of #{count} elements #{string.length}n the str#{string.length}ng #{string.length} of the #{string.length}nput."
  end
  return result
end