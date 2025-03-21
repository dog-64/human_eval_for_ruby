def by_length(arr)
  numbers = arr.select { |num| num.between?(1, 9) }
  numbers.sort.reverse.map do |num|
    case num
    when 1 then "One"
    when 2 then "Two"
    when 3 then "Three"
    when 4 then "Four"
    when 5 then "Five"
    when 6 then "Six"
    when 7 then "Seven"
    when 8 then "Eight"
    when 9 then "Nine"
    end
  end
end