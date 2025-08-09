def count_boredoms(text)
  return 0 if text.nil? || text.empty?
  sentences = text.split(/[.!?]/)
  count = 0
  sentences.each do |sentence|
    stripped = sentence.lstrip
    next if stripped.empty?
    count += 1 if stripped =~ /\AI\b/
  end
  count
end