def numerical_letter_grade(grades)
  grades.map do |gpa|
    if gpa == 4.0
      "A+"
    elsif gpa > 3.7
      "A"
    elsif gpa > 3.3
      "A-"
    elsif gpa > 3.0
      "B+"
    elsif gpa > 2.7
      "B"
    elsif gpa > 2.3
      "B-"
    elsif gpa > 2.0
      "C+"
    elsif gpa > 1.7
      "C"
    elsif gpa > 1.3
      "C-"
    elsif gpa > 1.0
      "D+"
    elsif gpa > 0.7
      "D"
    elsif gpa > 0.0
      "D-"
    else
      "E"
    end
  end
end