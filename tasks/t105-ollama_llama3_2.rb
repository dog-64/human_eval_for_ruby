def by_length(arr)
  one = 'One'
  two = 'Two'
  three = 'Three'
  four = 'Four'
  five = 'Five'
  six = 'Six'
  seven = 'Seven'
  eight = 'Eight'
  nine = 'Nine'

  arr.select { |x| x >= 1 && x <= 9 }.sort.reverse.map do |x|
    case x
    when 1 then one
    when 2 then two
    when 3 then three
    when 4 then four
    when 5 then five
    when 6 then six
    when 7 then seven
    when 8 then eight
    when 9 then nine
    end
  end
end