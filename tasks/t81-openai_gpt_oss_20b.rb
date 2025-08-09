def numerical_letter_grade(grades)
  grades.map do |g|
    unless g.is_a?(Numeric)
      raise ArgumentError, "All elements must be numeric"
    end
    if g < 0.0 || g > 4.0
      raise ArgumentError, "GPA must be between 0.0 and 4.0"
    end
    case
    when g == 4.0
      "A+"
    when g > 3.7
      "A"
    when g > 3.3
      "A-"
    when g > 3.0
      "B+"
    when g > 2.7
      "B"
    when g > 2.3
      "B-"
    when g > 2.0
      "C+"
    when g > 1.7
      "C"
    when g > 1.3
      "C-"
    when g > 1.0
      "D+"
    when g > 0.7
      "D"
    when g > 0.0
      "D-"
    else
      "E"
    end
  end
end