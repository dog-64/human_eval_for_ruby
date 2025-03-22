def match_parens(lst)
  str1, str2 = lst
  
  ["#{str1}#{str2}", "#{str2}#{str1}"].any? do |s|
    count = 0
    s.each_char do |c|
      if c == '('
        count += 1
      elsif count > 0
        count -= 1
      else
        return 'No'
      end
    end
    count == 0
  end ? 'Yes' : 'No'
end
