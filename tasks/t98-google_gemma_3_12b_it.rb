def count_upper(s)
  count = 0
  (0...s.length).step(2) do |i|
    if s[i] == 'A' || s[i] == 'E' || s[i] == 'I' || s[i] == 'O' || s[i] == 'U'
      count += 1
    end
  end
  count
end
