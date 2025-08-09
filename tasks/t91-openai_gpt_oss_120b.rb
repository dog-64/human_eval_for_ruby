def count_boredoms(text)
  return 0 if text.nil? || text.empty?
  count = 0
  text.split(/[.!?]/).each do |segment|
    trimmed = segment.lstrip
    next if trimmed.empty?
    count += 1 if trimmed.start_with?('I')
  end
  count
end