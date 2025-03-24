def count_boredoms(text)
  text.split(/(?<=[.?!])\s+/).count { |sentence| sentence.strip.start_with?('I ') }
end