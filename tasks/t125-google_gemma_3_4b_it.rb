def split_words(txt)
  if txt.include?(' ') || txt.include?(',')
    txt.split(/[,\s]+/)
  else
    count = 0
    lower_chars = 'abcdefghijklmnopqrstuvwxyz'
    result = 0
    txt.each_char do |char|
      if char =~ lower_chars
        count += 1
        if count % 2 != 0
          result += 1
        end
      end
    end
    result
  end
end
