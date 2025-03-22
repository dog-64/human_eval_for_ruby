def match_parens(lst)
  s1, s2 = lst

  def is_balanced(s)
    balance = 0
    s.chars.each do |char|
      if char == '('
        balance += 1
      else
        balance -= 1
        return false if balance < 0
      end
    end
    balance == 0
  end

  [s1 + s2, s2 + s1].any? { |s| is_balanced(s) } ? 'Yes' : 'No'
end