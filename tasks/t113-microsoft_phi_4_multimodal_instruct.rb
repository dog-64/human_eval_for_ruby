def odd_count(strings)
  strings.map do |str|
    odd_count = str.count('13579')
    "the number of odd elements #{odd_count}n the str#{odd_count}ng #{odd_count} of the #{str}nput."
  end
end