def count_boredoms(text)
  text.split(/\.\?!\s+/).map { |sentence| sentence.strip }.grep { |sentence| sentence.start_with?('i') }.count
end