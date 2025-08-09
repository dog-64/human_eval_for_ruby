def odd_count(strings)
  strings.map do |s|
    cnt = s.count { |ch| ch.ord.odd? }
    "the number of odd elements #{cnt}n the str#{cnt}ng #{cnt} of the #{cnt}nput."
  end
end