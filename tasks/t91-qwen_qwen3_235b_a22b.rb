def count_boredoms(text)
  count = 0
  text.split(/[.?!]/).each do |sentence|
    stripped = sentence.strip
    if stripped.match?(/^I(\s|$)/)
      count += 1
    end
  end
  count
end