def numerical_letter_grade(grades)
  raise ArgumentError, "Input must be an array" unless grades.is_a?(Array)

  grades.map do |g|
    unless g.is_a?(Numeric) && g >= 0.0 && g <= 4.0
      raise ArgumentError, "Each grade must be a number between 0.0 and 4.0"
    end

    if g == 4.0
      "A+"
    elsif g > 3.7
      "A"
    elsif g > 3.3
      "A-"
    elsif g > 3.0
      "B+"
    elsif g > 2.7
      "B"
    elsif g > 2.3
      "B-"
    elsif g > 2.0
      "C+"
    elsif g > 1.7
      "C"
    elsif g > 1.3
      "C-"
    elsif g > 1.0
      "D+"
    elsif g > 0.7
      "D"
    elsif g > 0.0
      "D-"
    else
      "E"
    end
  end
end