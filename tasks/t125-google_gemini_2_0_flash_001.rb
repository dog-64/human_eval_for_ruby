def split_words(txt)
  if txt.include?(" ") || txt.include?(",")
    txt.split(/[ ,]+/)
  else
    count = 0
    txt.each_char.with_index do |char, index|
      if char =~ /[a-z]/
        ascii_code = char.ord - 'a'.ord
        if ascii_code % 2 != 0
          count += 1
        end
      end
    end
    count
  end
end