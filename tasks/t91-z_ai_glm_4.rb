
def count_boredoms(text)
  segments = text.split(/[.!?]/)
  count = 0
  segments.each do |segment|
    stripped = segment.strip
    next if stripped.empty?
    count += 1 if stripped.match?(/^I\b/)
  end
  count
end