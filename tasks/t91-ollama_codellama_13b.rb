def count_boredoms(text)
  text.scan(/I\b/).count
end