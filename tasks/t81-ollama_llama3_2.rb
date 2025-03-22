def numerical_letter_grade(grades)
  grades = grades.map(&:to_f)
  return [] if grades.empty?
  return [] if grades.any? { |g| g < 0 || g > 4 }
  result = []
  (0..4).each do |i|
    count = grades.count(i / 0.1)
    result << "A#{i / 10}" * count
  end
  return result
end