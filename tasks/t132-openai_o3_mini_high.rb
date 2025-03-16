def is_nested?(string)
  n = string.size
  (0...n).each do |i|
    balance = 0
    max_depth = 0
    (i...n).each do |j|
      if string[j] == '['
        balance += 1
        max_depth = balance if balance > max_depth
      else
        balance -= 1
        break if balance < 0
      end
      if balance == 0 && (j - i + 1) >= 4 && max_depth >= 2
        return true
      end
    end
  end
  false
end