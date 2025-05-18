def separate_paren_groups(paren_string)
  cleaned = paren_string.gsub(/\s+/, '')
  result = []
  current = ''
  balance = 0
  cleaned.each_char do |c|
    if c == '('
      if current.empty?
        balance += 1
        current += c
      else
        balance += 1
       