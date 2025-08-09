def odd_count(strings)
  strings.map do |s|
    odd_count = s.count('13579')
    "the number of odd elements #{odd_count}n the str#{odd_count}ng #{odd_count}nput."
  end
end