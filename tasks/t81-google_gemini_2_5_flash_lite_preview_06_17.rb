def numerical_letter_grade(grades)
  grades.map do |grade|
    case
    when grade == 4.0
      "A+"
    when grade > 3.7
      "A"
    when grade > 3.3
      "A-"
    when grade > 3.0
      "B+"
    when grade > 2.7
      "B"
    when grade > 2.3
      "B-"
    when grade > 2.0
      "C+"
    when grade > 1.7
      "C"
    when grade > 1.3
      "C-"
    when grade > 1.0
      "D+"
    when grade > 0.7
      "D"
    when grade > 0.0
      "D-"
    when grade == 0.0
      "E"
    else
      raise ArgumentError, "Invalid grade: #{grade}. Grades must be between 0.0 and 4.0."
    end
  end
end