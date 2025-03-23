
def make_palindrome(string)
  return string if string.empty?
  return string if string == string.reverse
  
  i = 0
  while i < string.length
    temp = string + string.reverse[0..i]
    if temp == temp.reverse
      return temp
    end
    i += 1
  end
  
  string + string.reverse
end
