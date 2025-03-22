[PYTHON]
def is_happy?(s)
  return false if s.length < 3
  s.each_char.with_index do |c, i|
    next_char = s[i+1]
    if c == next_char
      return false
    end
  end
  true
end
[/PYTHON]
