def numerical_letter_grade(grades)
  grades.map do |gpa|
    case gpa
    when 4.0
      "A+"
    when (3.7...4.0)
      "A"
    when (3.3...3.7)
      "A-"
    when (3.0...3.3)
      "B+"
    when (2.7...3.0)
      "B"
    when (2.3...2.7)
      "B-"
    when (2.0...2.3)
      "C+"
    when (1.7...2.0)
      "C"
    when (1.3...1.7)
      "C-"
    when (1.0...1.3)
      "D+"
    when (0.7...1.0)
      "D"
    when (0.0...0.7)
      "D-"
    when 0.0
      "E"
    else
      raise ArgumentError, "Invalid GPA value: #{gpa}"
    end
  end
end