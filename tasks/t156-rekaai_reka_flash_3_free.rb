
def int_to_mini_roman(number)
  raise ArgumentError, 'Number must be between 1 and 1000' unless (1..1000).include?(number)
  values = [
    [1000, 'm'],
    [900, 'cm'],
    [500, 'd'],
    [400, 'cd'],
    [100, 'c'],
    [90, 'xc'],
    [50, 'l'],
    [40, 'xl'],
    [10, 'x'],
    [9, 'ix'],
    [5, 'v'],
    [4, 'iv'],
    [1, 'i']
  ]
  result = ''
  values.each do |val, sym|
    while number >= val
      result += sym
      number -= val
    end
  end
  result
end

 