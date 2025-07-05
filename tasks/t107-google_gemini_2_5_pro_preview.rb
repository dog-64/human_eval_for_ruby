
 is fine. Or, the helper could be defined after the main function. The problem doesn't specify the order of helper functions. Usually, helper functions are defined before they are used, or if they are privatedef palindrome?(num)
  num.to_s == num.to_s.reverse
end

def even_odd_palindrome(n)
  even_