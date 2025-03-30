
def fizz_buzz(n)
  n <= 0 ? 0 : (1...n).select { |num| num % 11 == 0 || num % 13 == 0 }.sum { |num| num.to_s.count('7') }
end

 