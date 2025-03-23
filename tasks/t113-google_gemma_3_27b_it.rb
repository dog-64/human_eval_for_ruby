
def odd_count(strings)
  result = []
  strings.each do |str|
    odd_count = str.chars.count { |char| char.to_i.odd? }
    result << "the number of odd elements #{odd_count}n the str#{odd_count}ng #{odd_count} of the #{odd_count}nput."
  end
  result
end
