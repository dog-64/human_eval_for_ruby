def numerical_letter_grade(grades)
  letter_grades = []
  grades.each do |gpa|
    case gpa
    when 4.0
      letter_grades << "A+"
    when 3.7..4.0
      letter_grades << "A"
    when 3.3..3.7
      letter_grades << "A-"
    when 3.0..3.3
      letter_grades << "B+"
    when 2.7..3.0
      letter_grades << "B"
    when 2.3..2.7
      letter_grades << "B-"
    when 2.0..2.3
      letter_grades << "C+"
    when 1.7..2.0
      letter_grades << "C"
    when 1.3..1.7
      letter_grades << "C-"
    when 1.0..1.3
      letter_grades << "D+"
    when 0.7..1.0
      letter_grades << "D"
    when 0.0..0.7
      letter_grades << "D-"
    else
      raise ArgumentError, "Invalid GPA: #{gpa}"
    end
  end
  letter_grades
end