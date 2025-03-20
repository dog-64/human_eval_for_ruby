def compare_one(a, b)
  if a == b
    return nil
  elsif a > b
    return a
  else
    return b
  end
end
compare_one(1, 2.5)   # => 2.5
compare_one(1, "2,3")  # => "2,3"
compare_one("5,1", "6")  # => "6"
compare_one("1", 1)  # => nil
compare_one(3.14, "3.14")  # => nil
compare_one("-10", -5)  # => -5