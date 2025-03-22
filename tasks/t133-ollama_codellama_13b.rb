def sum_squares(lst)
  return 0 if lst.empty?
  lst.map { |x| (x.to_i ** 2).round }.sum
end
lst = [1, 2, 3]
puts sum_squares(lst) # Output: 14

lst = [1, 4, 9]
puts sum_squares(lst) # Output: 98

lst = [1, 3, 5, 7]
puts sum_squares(lst) # Output: 84

lst = [1.4, 4.2, 0]
puts sum_squares(lst) # Output: 29

lst = [-2.4, 1, 1]
puts sum_squares(lst) # Output: 6